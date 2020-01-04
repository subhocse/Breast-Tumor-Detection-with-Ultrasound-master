# -*- coding: utf-8 -*-
"""
Created on Thu Nov 14 21:42:31 2019

@author: Ruturaj
"""

import matplotlib.pyplot as plt;
import os;
import scipy;

import cv2;



def getVideoFrames(video):
    vidcap = cv2.VideoCapture(video);
    success,image = vidcap.read();
    count = 0;
    
    directory = "../Datasets/Breast Tumour/Images/Synthetic/Pork/" if "Pork" in video else "..Datasets/Breast Tumour/Images/Synthetic/Gel/";
    name = os.path.splitext(os.path.basename(video))[0];
    
    outputPath = directory + name;
    os.makedirs(outputPath, exist_ok = True);
    
    while success:
        cv2.imwrite(outputPath + "/frame_%d.jpg" % count, image);   # save frame as JPEG file      
        success,image = vidcap.read();
        count += 1;
    print(count, "frames created for", name);

def getImages(directory):
    
    images = {}
    
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith("png"):
                filepath = (os.path.join(root, file))
                filename = str.split(file, '.')[0];
                image = scipy.ndimage.imread(filepath, True);
                images[filename] = image;

    return images;

def saveImages(directory, derivativeImages, filteredDerivativeImages):
    parentDirectory = os.path.dirname(directory);
    
    derivativeImagesOutput = parentDirectory + "/Derivative Images/";
    filteredDerivativeImagesOutput = parentDirectory + "/Filtered Derivative Images/";
    
    os.makedirs(derivativeImagesOutput, exist_ok = True);
    os.makedirs(filteredDerivativeImagesOutput, exist_ok = True);
    
    for filename, image in derivativeImages.items():
        outputPath = derivativeImagesOutput + filename + "_derivative.jpeg";
        plt.imsave(outputPath, image, cmap = "gray", vmin = 20, vmax = 255);
        
    for filename, image in filteredDerivativeImages.items():
        outputPath = filteredDerivativeImagesOutput + filename + "_filtered_derivative.jpeg";
        plt.imsave(outputPath, image, cmap = "gray", vmin = 20, vmax = 255);