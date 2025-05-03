#!/usr/bin/env fontforge
# -*- coding: utf-8 -*-

import sys
import fontforge
import os
import time
import random
import psMat  # Needed for scaling

print(sys.argv)

# === USER INPUT ===
input_file = sys.argv[1]
# ===================

font = fontforge.open(input_file)

# --- Step 1: Set OS/2 version ---
font.os2_version = 2

# --- Step 2: Normalize names ---
def transform_name(name):
    return name.lower().replace(" ", "_")

font.familyname = transform_name(font.fontname)
font.fullname   = transform_name(font.fontname)
font.fontname   = transform_name(font.fontname)

# --- Step 3: Set EM size for .otf standard ---
if font.em != 1000:
    scale_factor = 1000.0 / font.em
    font.em = 1000
    font.selection.all()
    font.transform(psMat.scale(scale_factor))

# --- Step 4: Generate new unique ID ---
timestamp = str(int(time.time()))
rand_tag = ''.join(random.choices("abcdefghijklmnopqrstuvwxyz0123456789", k=4))
font.appendSFNTName('English (US)', 'UniqueID', f"{font.fontname};{timestamp};{rand_tag}")

# --- Step 5: Generate OTF output with '-fixed' appended to the filename ---
input_dir = os.path.dirname(os.path.abspath(input_file))
input_name = os.path.basename(input_file)  # Get just the file name
output_name = os.path.splitext(input_name)[0] + "-fixed.otf"  # Add '-fixed' before extension
output_file = os.path.join(input_dir, output_name)

font.generate(output_file)
font.close()

print(f"[fixfont] Saved: {output_file}")
