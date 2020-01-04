# -*- coding: utf-8 -*-
"""
Created on Tue Nov 12 11:25:49 2019

@author: Ruturaj
"""

import fileStorage;
import imageOperations;
import os;

def main():
    directory = "../Datasets/Breast Tumour/Images/Real/Benign/";

    images = fileStorage.getImages(directory);

    derivativeImages = { \
            filename: imageOperations.imageDerivative(image) \
            for filename, image in images.items() \
            };
    
    filteredDerivativeImages = { \
            filename: imageOperations.filterAndDerive(image) \
            for filename, image in images.items() \
            };

    fileStorage.saveImages(directory, derivativeImages, filteredDerivativeImages);    


if __name__ == "__main__":
    main();
