import os
import cv2
import pandas as pd
import numpy as np
from skimage.util.shape import view_as_blocks
from skimage.transform import resize


def generate_patches_from_img(img, patch_size=128):
    """This function divides the image into equally sized patches.base

    Parameters
    ----------
    img: numpy array of image, in RGB format (from opencv)
    size: size of the patch

    Returns
    -------
    dict: (row, col): img
    """

    new_width, new_height, channels = img.shape

    if img.shape[0] % 128 != 0:
        new_width = img.shape[0] + (128 - img.shape[0] % 128)

    if img.shape[1] % 128 != 0:
        new_height = img.shape[1] + (128 - img.shape[1] % 128)

    resized_img = resize(img, (new_width, new_height))

    block_shape = (128, 128, 3)
    img_blocks = view_as_blocks(resized_img, block_shape=block_shape)

    img_patches = {}

    for r in range(img_blocks.shape[0]):
        for c in range(img_blocks.shape[1]):
            img = img_blocks[r, c]
            img = np.reshape(img, (128, 128, 3))
            img_patches[(r, c)] = img

    return img_patches

