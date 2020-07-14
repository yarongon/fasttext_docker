# Docker for fastText Training

[fastText](https://fasttext.cc/) is a library for learning text classification and word representations,
created by [Fascebook AI Research](https://research.fb.com/category/facebook-ai-research/).

From the official fastText documentation:
> What is fastText?\
\
FastText is an open-source, free, lightweight library that allows users to learn text representations and text classifiers. It works on standard, generic hardware. Models can later be reduced in size to even fit on mobile devices.

Compiling fastText requires C++ build tool and other stuff that are usually not installed in non-C++ development machines.
This Dockerfile will create a small image that compiles everything for you.
All you need to do is to supply the data (in the right format) and run fastText.

## Usage

### Build the image
First, pull the repo from Github.
```sh
git clone https://github.com/yarongon/fasttext_docker.git
```

Then, build the docker image for training:
```sh
docker build -t fasttext .
```

### Train the model
Run the training container by mounting two volumes, `/data` and `/models`, and then supplying the parameters that fastText accept:
```sh
docker run \
    --rm \
    -v $DATA_DIR:/data \
    -v $MODELS_DIR:/models \
    fasttext supervised \
      -input /data/<training data> \
      -output /models/<output model filename>
```

* `DATA_DIR` is the full path of the input directory that contains the training data, e.g., `TRAIN_DIR=/data/train/`.
* `MODELS_DIR` is the full path to the output directory that stores the fastText trained models `model.bin` to be generated, e.g., `MODEL_DIR=/data/models/`.
