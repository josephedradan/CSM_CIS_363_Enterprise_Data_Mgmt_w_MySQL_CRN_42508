"""
2/16/2020

Purpose:
    Format OCR String for assignment 1 and 2 

Reference:
    AutoRemoveLineBreak.py

"""

import sys
import os
import json
import threading
import re
import time

import pyperclip

from joseph_library.decorators._old.timer_prefix import timer_prefix
# Now will work for Non Pycharm interpreters
PATH_DICTIONARY_CUSTOM = os.path.splitext(os.path.abspath(__file__))[0] + "_Custom_Dictionary.json"


class RemoveLineBreak:
    def __init__(self, text_initial=None, wait_time=.75, toggle=False, run=True):
        threading.Thread.__init__(self)

        # Text from
        self.text_initial = text_initial
        self.text_modified = ""
        self.wait_time = wait_time

        self.toggle = toggle

        if run:
            self.run()

    def _operation(self, text_new):
        # Replace current raw_string
        self.text_initial = text_new

        # Raw string to modified string
        self._modify_text_standard()

        # Modified string with user custom replace
        # self._modify_text_replace_custom()

        # Clean Modified String
        self._modify_text_clean()

        # time.sleep(.1)
        # .1 is the fastest Balabolka can read the clipboard after previous clipboard

        # Replace current clipboard
        self._replace_clipboard()
        print()

    # Gets clipboard string and modifies it.
    @prefix_timer
    def _modify_text_standard(self):

        # Replace newline, carriage return, tab with space
        new_text = self.text_initial
        # new_text = self.raw_string.strip().replace('\r', ' ').replace('\t', ' ')

        # Replace _ with ' '
        # new_text = new_text.replace('_', ' ')

        # Remove multiple spaces
        # new_text = re.sub(" +", " ", new_text)

        # match ? or , or . or ! and substitute it to ,
        # new_text = re.sub("[?!.]", ",", new_text)

        # Replace format "Page #" with "" for HIST 201
        # new_text = re.sub(r'Page (\d+)', "", new_text)

        print("1.String has been modified")

        self.text_modified = new_text

    @prefix_timer
    def _modify_text_replace_custom(self):
        temp_string = self.text_modified

        with open(PATH_DICTIONARY_CUSTOM, "r") as file:
            dict_custom = json.load(file)  # loads = string, load = File object
            for key, value in dict_custom.items():
                temp_string = re.sub(key, value, temp_string)

        self.text_modified = temp_string

        print("1A.String has been modified with custom dict")

    @prefix_timer
    def _modify_text_clean(self):
        # https://stackoverflow.com/questions/7147396/python-how-to-delete-hidden-signs-from-string
        # You can filter your string using str.isprintable() (from PEP-3138):
        self.text_modified = "".join(word for word in self.text_modified if word.isprintable())

        print("2.String has been cleaned")

    @prefix_timer
    def _replace_clipboard(self):
        pyperclip.copy(self.text_modified)
        # pyperclip.copy(self.modified_string)
        # pyperclip.copy(self.modified_string)
        # time.sleep(.2)  # For Balabolka
        # pyperclip.copy(self.modified_string)
        print("3.String has been replaced")

    def run(self):
        if self.toggle:
            while self.toggle:
                time.sleep(self.wait_time)
                if pyperclip.paste() != self.text_modified:
                    self._operation(pyperclip.paste())
        else:
            self._operation(pyperclip.paste())


if __name__ == "__main__":
    RemoveLineBreak(toggle=True)
