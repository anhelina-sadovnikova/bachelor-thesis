1) sorted_file_classes analyzes the dataset to determine the number of images belonging to each class.
2) Image_sorting analyzes how often each image appears in the table, which is part of the dataset and contains all the information about it.
3) random_pictures_from_each_class is a script that selects up to 600 images for each class to create a new dataset.
4) creating_table_for_classification is a script that creates a table with labels for classification.
5) masks_borders creates labels for segmentation, specifically masks indicating the location of each diagnosis present in the image.
6) train-validation-test_split divides images and masks for segmentation into three datasets – training, testing, and validation.
7) training-20240425 is a script that trains a neural network for segmentation using the UNET architecture.
8) testing_all is a script that will perform segmentation on the test dataset and save the images to a different folder.
9) segmentation is a script that performs image segmentation using the DeepLab v3 architecture in MATLAB.
10) testing_segmentation performs segmentation of the test dataset in MATLAB.
11) classification_on_segmentation_all determines which classes were segmented in the test dataset and compare this with the actual classes to evaluate the model.
