# Docker Container for fastText Model Training

[fastText](https://fasttext.cc/) is a library for learning text classification and word representations,
created by [Fascebook AI Research](https://research.fb.com/category/facebook-ai-research/).

From the official fastText documentation:
> What is fastText?\
\
FastText is an open-source, free, lightweight library that allows users to learn text representations and text classifiers. It works on standard, generic hardware. Models can later be reduced in size to even fit on mobile devices.

Compiling fastText requires C++ build tool and other stuff that are usually not installed in non-C++ development machines, and differ between different OSs.
This Dockerfile will create a small image that compiles everything for you.
All you need to do is to supply the data (in the right format) and run fastText.

The difference between this container and other containers out there is the fact that this one is based only on the basic Ubuntu image, and does not require Python, which makes it very small (less than 380MB)

## Pulling the Image
The simplest usage is to pull the image from the [Docker hub](https://hub.docker.com/r/yarongon/fasttext):
```sh
docker pull yarongon/fasttext
```
Now you can [train a model](#train-a-model).

Alternatively, you can [build the image](#build-the-image).

## Build the image
If you wish to build the image by yourselves, first, pull the repo from Github.
```sh
git clone https://github.com/yarongon/fasttext_docker.git
```

Then, build the docker image for training:
```sh
docker build -t fasttext .
```

## Usage
The endpoint in the Dockerfile is the fastText binary, so generally, to use the image, simply pass the parameters used by fastText.
Following are a few examples.

### Train a Model
Run the container by mounting two volumes, `/data` and `/models`, and then supplying the parameters that fastText accept. For example:
```sh
docker run \
  --rm \
  -v $DATA_DIR:/data \
  -v $MODELS_DIR:/models \
  yarongon/fasttext supervised \
    -input /data/<training data> \
    -output /models/<output model filename>
```

* `DATA_DIR` is the full path of the input directory that contains the training data, e.g., `TRAIN_DIR=/data/train/`.
* `MODELS_DIR` is the full path to the output directory that stores the fastText trained models `model.bin` to be generated, e.g., `MODEL_DIR=/data/models/`.

Another example, using fastText's autovalidation:
```sh
docker run \
  --rm \
  -v $DATA_DIR:/data \
  -v $MODELS_DIR:/models \
  yarongon/fasttext supervised \
    -input /data/<training data> \
    -output /models/<output model filename> \
    -autotune-validation /data/<validation data> \
    -autotune-duration 10000 \
    -verbose 5
```

### Make a Prediction
Run the container by mounting only the models directory.
The following is a command to make a prediction accepted at the command prompt.
```sh
docker run \
  --rm \
  -it \
  -v $MODELS_DIR:/models \
  yarongon/fasttext predict /models/<model filename> -
```