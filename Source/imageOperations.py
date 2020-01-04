# -*- coding: utf-8 -*-
"""
Created on Thu Nov 14 21:44:04 2019

@author: Ruturaj
"""

from PIL import Image;
from skimage import filters;
from skimage import morphology;
from skimage import segmentation;

from scipy import ndimage;

def imageDerivative(image):
    return ndimage.sobel(image, axis = 0);

def filterAndDerive(image):
    image = ndimage.median_filter(image, 3);
    return imageDerivative(image);

def rgb2gray(imagePath):
    return Image.open(imagePath).convert("LA");

def median_filter(image):
    return filters.median(image, 3);

def otsu_segmentation(image):
    return filters.threshold_otsu(image);

def local_threshold(image):
    return filters.threshold_local(image);

def k_means(image):
    return segmentation.slic(image);

def watershed(image):
    return morphology.watershed(image);