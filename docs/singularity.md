
# Containers (Singularity & Docker)

Containers are a popular way of creating a reproducible software environment. Container solutions are Docker and Singularity/Apptainer, we support singularity.

The [Singularity user guides](https://docs.sylabs.io/guides/3.9/user-guide/) are a great resource for learning what you can do with singularity


<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Running a container 

---


native installation from Rocky 8 EPEL of `singularity-ce version 4.1.5-1.el8`, no modules to load.

### _On all nodes using CPU only_

pull the docker image you want, here ubuntu:18.04

    singularity pull docker://ubuntu:18.04

write an sbatch file (here called `ubuntu.slurm`):

    #!/bin/bash
    #SBATCH -t 0-00:30
    #SBATCH -N 1
    #SBATCH -c 1
    #SBATCH --cpus-per-task=2   #singularity can use multiple cores
    #SBATCH --mem-per-cpu=4000
    singularity exec docker://ubuntu:18.04 cat /etc/issue

submit to the queueing system with

    sbatch ubuntu.slurm

and when the resources become available, your job will be executed.





### _On GPU nodes (using GPU)_

When running singularity through SLURM (srun, sbatch) only GPUs reverved through SLURM are visible to singularity.



pull the docker image you want, here ubuntu:20.04:

    singularity pull docker://ubuntu:20.04

write an sbatch file (here called `ubuntu.slurm`):

    #!/bin/bash
    #SBATCH -t 0-00:30
    #SBATCH -N 1
    #SBATCH -c 1
    #SBATCH -p gpu
    #SBATCH --gres=gpu:A100:1     #only use this if your job actually uses GPU
    #SBATCH --mem-per-cpu=4000
    singularity exec --nv docker://ubuntu:20.04 nvidia-smi
    # or singularity exec --nv ubuntu_20.04.sif nvidia-smi
    # the --nv option to singularity passes the GPU to it

submit to the queueing system with

    sbatch ubuntu.slurm

and when the resources become available, your job will be executed.


More on singularity and GPUs, see <https://sylabs.io/guides/3.9/user-guide/gpu.html>.



### _Hints_

By default there is no network isolation in Singularity, so there is no need to map any port (-p in docker). If the process inside the container binds to an IP:port, it will be immediately reachable on the host. Singularity also mounts $HOME and $TMP by default so the directory you run the container from will be the working directory within the container (unless the directory is not on the same filesystem as $HOME).

Singularity will use all cores reserved using `--cpus-per-task`, if less should be used, the singularity parameter `--cpus` can be used, similarly, if a container should use less memory, this can be restricted by the singularity parameter `--memory`. These parameters can be useful, if a single batch job starts several containers concurrently.

<!-- 
Converting from Docker.io, see

<https://www.nas.nasa.gov/hecc/support/kb/converting-docker-images-to-singularity-for-use-on-pleiades_643.html>
-->


<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Example: Interactive PyTorch job (without and with GPU)

---

Start an interactive session on amp, make the modules available and run the docker image in singularity:

Without GPU:

    srun -t 1:00:00 --pty bash
    singularity exec docker://pytorch/pytorch python

With GPU:

    srun -t 1:00:00 -p gpu --gres=gpu:1 --pty bash
    singularity exec --nv docker://pytorch/pytorch python

inside the container python session run

    import torch
    torch.cuda.is_available()
    torch.cuda.get_device_name()

You can also shorten it to a single command

    srun -t 1:00:00 -p gpu --mem 32G --gres=gpu:1 singularity exec docker://pytorch/pytorch python -c "import torch;print(torch.cuda.is_available())"

which should give the same result (without the GPU name). If you remove the `--nv` flag the result changes as singularity no longer exposes the gpu.


<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Example: Interactive TensorFlow job  (without and with GPU)

---

Start an interactive session on amp, make the modules available and run the docker image in singularity:

Without GPU:

    srun -t 1:00:00 --mem=16G --pty bash
    singularity run docker://tensorflow/tensorflow

With GPU:

    srun -t 1:00:00 -p gpu --gres=gpu:1 --mem=16G --pty bash
    singularity run --nv docker://tensorflow/tensorflow:latest-gpu
    
With GPU and jupyter:

    srun -t 1:00:00 -p gpu --gres=gpu:1 --mem=16G --pty bash
    singularity run --nv docker://tensorflow/tensorflow:latest-gpu-jupyter


inside the container run

    python
    from tensorflow.python.client import device_lib
    print(device_lib.list_local_devices())

The following is the "TensorFlow 2 quickstart for beginners" from <https://www.tensorflow.org/tutorials/quickstart/beginner>, continue inside the python:

 <!-- example is CC-BY-4.0 and Apache 2.0 License -->

 
    import tensorflow as tf
    print("TensorFlow version:", tf.__version__)
    mnist = tf.keras.datasets.mnist
    (x_train, y_train), (x_test, y_test) = mnist.load_data()
    x_train, x_test = x_train / 255.0, x_test / 255.0

    model = tf.keras.models.Sequential([
      tf.keras.layers.Flatten(input_shape=(28, 28)),
      tf.keras.layers.Dense(128, activation='relu'),
      tf.keras.layers.Dropout(0.2),
      tf.keras.layers.Dense(10)
    ])
    predictions = model(x_train[:1]).numpy()
    predictions
    tf.nn.softmax(predictions).numpy()
    loss_fn = tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True)
    loss_fn(y_train[:1], predictions).numpy()
    model.compile(optimizer='adam', loss=loss_fn, metrics=['accuracy'])
    model.fit(x_train, y_train, epochs=5)
    model.evaluate(x_test,  y_test, verbose=2)
    probability_model = tf.keras.Sequential([
      model,
      tf.keras.layers.Softmax()
    ])
    probability_model(x_test[:5])


<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Example job for OpenDroneMap (ODM)

---

OpenDroneMap needs a writable directory for the data. This directory needs to contain a subdirectory named `images`.

Assume you keep your ODM projects in the directory `opendronemap`:

    opendronemap
    |
    |-Laagna-2021
    | |
    | |-images
    |
    |-Paldiski-2015
    | |
    | |-images
    |
    |-Paldiski-2018
    | |
    | |-images
    |
    |-TalTech-2015
    | |
    | |-images

If you want to create a 3D model for Laagna-2021, you would run the following Singularity command:

    singularity run --bind $(pwd)/opendronemap/Laagna-2021:/datasets/code docker://opendronemap/odm --project-path /datasets

For creating a DEM, you would need to add `--dsm` and potentially `-v "$(pwd)/odm_dem:/code/odm_dem"`

GPU use for singularity is enabled with the `--nv` switch, be aware that ODM uses the GPU only for the matching, which is only a small percentage of the time of the whole computation.

The SLURM job-script looks like this:
   
    #!/bin/bash
    #SBATCH --nodes 1
    #SBATCH --ntasks 1
    #SBATCH --cpus-per-task=10
    #SBATCH --time 01:30:00
    #SBATCH --partition gpu
    #SBATCH --gres=gpu:A100:1
    
    
    singularity run --nv --bind $(pwd)/opendronemap/Laagna-2021:/datasets/code docker://opendronemap/odm --project-path /datasets --dsm





<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Obtaining and Building Singularity Containers

---

When you want to use a container with the cluster you'll need to get the image from somewhere and you cannot build containers on the cluster for security reasons (even with `--fakeroot`) so there are two ways to get your containers into the cluster.

### From Container Registries

Singularity can pull and convert docker images from docker container registeries (most significantly [dockerhub](https://hub.docker.com/)) directly into singularity images. This is the method used in the previous examples.
You can read more here: <https://docs.sylabs.io/guides/3.9/user-guide/singularity_and_docker.html>

You can also use [GitHub's Container Registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry) or [TalTech's Software Science Gitlab](https://gitlab.cs.ttu.ee) (You'll need to sign in with an access token to pull containers from the registry, more on that here <https://docs.sylabs.io/guides/3.9/user-guide/endpoint.html>)


### _Building images locally then moving to cluster_
Since Singularity images are single files you can transfer them quite easily with any tool used to sync data with the cluster, `scp`, `rsync` etc. You can build locally with either just the `singularity` tool or `singularity` and `docker`
- [Building images](https://docs.sylabs.io/guides/3.9/user-guide/build_a_container.html) from [singularity definition file](https://docs.sylabs.io/guides/3.9/user-guide/definition_files.html) then transferring to the cluster.
- Building images with docker from dockerfiles then saving the image docker save to an archive e.g

```bash
docker build -t pytorch .
docker save pytorch | gzip > pytorch.tar.gz
```

creates a file `pytorch.tar.gz` which you can either convert to a singularity image locally with `singularity build docker-archive//pytorch.tar.gz` or you can move the archive to the cluster and build from there. Building from a docker archive is the only form of image building allowed in the cluster.

<br>
