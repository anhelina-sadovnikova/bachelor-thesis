clear
clc

% Load the training images
imds = imageDatastore('images_train-kopie/');

% Load the training masks
labelDir = 'masks_train-kopie/';

classNames = ["Nofinding","Nodule_Mass","ILD","Lung_Opacity","Consolidation","Aortic_enlargement","Pleural_thickening","Calcification","Pulmonary_fibrosis","Cardiomegaly","Pleural_effusion","Other_lesion","Infiltration","Atelectasis","Pneumothorax"];
labelIDs   = [0 255 237 219 201 183 165 147 129 111 93 75 57 39 21];
pxds = pixelLabelDatastore(labelDir,classNames,labelIDs);

imageSize = [300 300];
numClasses = numel(classNames);
lgraph = deeplabv3plus(imageSize,numClasses,"xception");

pximds = pixelLabelImageDatastore(imds,pxds,'OutputSize',imageSize,'ColorPreprocessing','gray2rgb');
valimgs=imageDatastore('.\imgs_val');
vallbls=pixelLabelDatastore('.\masky_val',classNames,labelIDs);
cimgs=pixelLabelImageDatastore(valimgs,vallbls,'OutputSize',imageSize,'ColorPreprocessing','gray2rgb');

opts = trainingOptions("adam",...
    MiniBatchSize=16,...
    MaxEpochs=100,...
    Plots="training-progress",...
    Shuffle="every-epoch",...
    ValidationData=cimgs,...
    ValidationFrequency=30);

net = trainNetwork(pximds,lgraph,opts);
