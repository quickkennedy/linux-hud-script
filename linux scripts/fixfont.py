#!/usr/bin/env fontforge
# -*- coding: utf-8 -*-

import sys
import fontforge
import os

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

# --- Step 4: Let FontForge generate a randomized UniqueID ---
font.uniqueid = -1  # -1 tells FontForge to generate a valid UniqueID automatically
print("[debug] UniqueID set to:", font.uniqueid)

# --- Step 5: Generate OTF output with '-fixed' appended to the filename ---
input_dir = os.path.dirname(os.path.abspath(input_file))
input_name = os.path.basename(input_file)  # Get just the file name
output_name = os.path.splitext(input_name)[0] + "-fixed.otf"  # Add '-fixed' before extension
output_file = os.path.join(input_dir, output_name)

font.generate(output_file)
font.close()

print(f"[fixfont] Saved: {output_file}")
