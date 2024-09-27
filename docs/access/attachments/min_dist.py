import os
import time
import torchvision
import torch.distributed as dist
import torch.nn.functional as F
import torch.optim as optim
from torch.nn.parallel import DistributedDataParallel
from torch.utils.data import DataLoader, DistributedSampler

dataset_size = 50000
num_epochs = 5
batch_size = 128

if __name__ == "__main__":
    dist.init_process_group("nccl")
    try:
        dist.barrier()
        world_size = dist.get_world_size()
        rank = dist.get_rank()
        device = int(os.environ["LOCAL_RANK"])
        nnodes = int(os.environ["SLURM_NNODES"])
        
        if rank == 0:
            print(f"{world_size} GPU processes in total across {nnodes} nodes")
            print("Batch size =", batch_size)
            print("Dataset size =", dataset_size)
            print("Epochs =", num_epochs)
            print()

        model = torchvision.models.resnet152().to(device)
        optimizer = optim.SGD(model.parameters(), lr=0.01)

        ddp_model = DistributedDataParallel(model)        

        transform = torchvision.transforms.Compose([
            torchvision.transforms.Resize((224, 224)),
            torchvision.transforms.ToTensor()
        ])
        
        dataset = torchvision.datasets.FakeData(size = dataset_size, image_size = (3, 255, 255), num_classes = 1000, transform = transform)

        train_sampler = DistributedSampler(
            dataset,
            num_replicas=world_size,
            rank=rank,
            shuffle=False,
        )

        train_loader = DataLoader(
            dataset,
            batch_size=batch_size,
            shuffle=False,
            sampler=train_sampler,
            pin_memory=True,
            num_workers=1
        )

        if rank == 0:
            print("Training")
        for epoch in range(num_epochs):
            start = time.perf_counter()
            for images, labels in train_loader:
                optimizer.zero_grad()
                output = ddp_model(images.to(device))
                loss = F.cross_entropy(output, labels.to(device))
                loss.backward()
                optimizer.step()

            end = time.perf_counter()

            if rank == 0:
                print(f"Epoch {epoch}  done in {end - start}s")
        
        if rank == 0 : 
            print("DONE")
    finally:
        dist.barrier()
        dist.destroy_process_group()
