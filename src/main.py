import numpy as np


class AppFeature:
    """ App Feature """

    def __init__(self):
        """ App Feature """
        print("HELLO WORLD", flush=True)
        pass

    @staticmethod
    def adding(x, y):
        """ This is main function """
        print("THIS IS AN ADDING FUNCTION")
        return np.sum([x, y])
