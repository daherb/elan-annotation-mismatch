# elan-annotation-mismatch
An XLST script to check if the token count between a main tier and a tier linked by reference, e.g. a transcription and a morphology gloss tier. 
The referencing tier can be selected by modifying the variable `morpho_tier_name` at the top of the file.

Tested with Saxon9. To run it use e.g. `saxon9-transform -xsl:problematic_annotations.xsl -o:outfile.xml infile.eaf`