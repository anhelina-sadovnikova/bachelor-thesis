% load the model
load('dlab_anh_1_aug.mat');

% load the image
img = imread('images_train-kopie/0a1aef5326b7b24378c6692f7a454e52.png');

% resize the image
I = imresize(img, [300, 300]);

% perform segmentation
C = semanticseg(I, net);

% display the result
B = labeloverlay(I, C);
figure (1)
imshow(B);

% ONE IMAGE

% mapping function
categories = {'Nodule_Mass', 'ILD', 'Lung_Opacity', 'Consolidation', ...
    'Aortic_enlargement', 'Pleural_thickening', 'Calcification', ...
    'Pulmonary_fibrosis', 'Cardiomegaly', 'Pleural_effusion', ...
    'Other_lesion', 'Infiltration', 'Atelectasis', 'Pneumothorax', 'Nofinding'};
values = [255, 237, 219, 201, 183, 165, 147, 129, 111, 93, 75, 57, 39, 21, 0];
categoryMap = containers.Map(categories, values);

% convert categorical data to grayscale values
grayscaleImage = uint8(zeros(size(C)));
for i = 1:numel(categories)
    grayscaleImage(C == categories{i}) = categoryMap(categories{i});
end

figure(2);
imshow(grayscaleImage);

% ALL IMAGES IN FOLDER

% folder containing the images
folderPath = 'images_test/';
imageFiles = dir(fullfile(folderPath, '*.png'));  % Adjust the file type if necessary

% new folder to save images
newFolderPath = 'grayscale_images_aug/';
if ~exist(newFolderPath, 'dir')
    mkdir(newFolderPath);
end

categories = {'Nodule_Mass', 'ILD', 'Lung_Opacity', 'Consolidation', ...
    'Aortic_enlargement', 'Pleural_thickening', 'Calcification', ...
    'Pulmonary_fibrosis', 'Cardiomegaly', 'Pleural_effusion', ...
    'Other_lesion', 'Infiltration', 'Atelectasis', 'Pneumothorax', 'Nofinding'};
values = [255, 237, 219, 201, 183, 165, 147, 129, 111, 93, 75, 57, 39, 21, 0];
categoryMap = containers.Map(categories, values);

for i = 1:length(imageFiles)
    filePath = fullfile(folderPath, imageFiles(i).name);
    img = imread(filePath);
    I = imresize(img, [300, 300]);
    C = semanticseg(I, net);
    grayscaleImage = uint8(zeros(size(C)));
    for j = 1:numel(categories)
        grayscaleImage(C == categories{j}) = categoryMap(categories{j});
    end
    [~, name, ~] = fileparts(imageFiles(i).name);
    imwrite(grayscaleImage, fullfile(newFolderPath, [name '.png']));
end

