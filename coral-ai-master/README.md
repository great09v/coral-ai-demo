# coral-ai

## What we are building:
An image classifier that can label an image as coral or non-coral
The trained model will be packaged as an API.
The API will be accessed through a web app that allows users to upload new images and get classifications in real time
 
## Overall Goal:
Accelerate the processing of benthic images collected from unmanned underwater vehicles from the GBR  from 15 minutes per image (human export) to hundreds of images per second (machine learning model)
 
## Preliminary System Architecture
![App Engine (Google Cloud Platform) or any equivalent in AWS or Azure](image/architecture.png)

**App Engine (Google Cloud Platform) or any equivalent in AWS or Azure*

## Directory Structure
###### Binary Classification:   
https://github.com/fastai/fastai/blob/master/courses/dl1/lesson1.ipynb
```
train:
 cat:
  image1.jpg
  image2.jpg
  ...
 dog:
  image1.jpg
  iamge2.jpg
  ...
  
valid:
 cat:
  image1.jpg
  image2.jpg
  ...
 dog:
  image1.jpg
  image2.jpg
  ...

test:
 image1.jpg
 image2.jpg
 ...
```
###### Multiple Classification:  
https://github.com/fastai/fastai/blob/master/courses/dl1/lesson1-breeds.ipynb   
https://www.kaggle.com/c/dog-breed-identification/data    
```
labels.csv
    image_id                            class
1   000bec180eb18c7604dcecc8fe0dba07	boston_bull
2   001513dfcb2ffafc82cccf4d8bbaba97	dingo
3   001cdf01b096e06d78e9e5112d419397	pekinese
...

train
 image1.jpg
 image2.jpg
 ...
 
test
 image1.jpg
 image2.jpg
 ...
``` 


Pre-work (Duration: 4 weeks)
----------------------------------------
Objective: Build a working end-to-end system
 
#### Jan 28 – Feb 1
Set up Github repo (Christine)
Upload dataset to temporary Data Storage (Christine)
Exploratory Analysis of Dataset i.e. distribution of labels for coral/non-coral, coral species (Christine)
Generate train, validation, test split (Baichuan)
Shortlist pre-trained deep learning models to be used (Baichuan)
 
#### Feb 4 – Feb 8
Train models on local GPU (Baichuan)
Persist models into data storage storage (Baichuan)
 
#### Feb 11 – Feb 15
Build an API endpoint to serve the persisted model (TBD)
Simple web app for uploading photos and doing online prediction by sending a request to API (TBD)
Cloud infrastructure for serving the trained model and hosting the web app (@Younggu Yun)
 
#### Feb 18 – Feb 22
(Buffer period)
 
#### During Offsite (Half-day, Feb 28)
Objective: Build a model explanation module and do error analysis  
In a Jupyter notebook, build a tool that can examine the patterns learned at each layer of the neural network (Link to Similar Work)   
Incorporate SHAP’s GradientExplainer (https://github.com/slundberg/shap)


---
Dataset: https://www.nature.com/articles/sdata201557#t1  
Related Literature: https://homepages.inf.ed.ac.uk/rbf/PAPERS/amoceans17.pdf