# Codebook for run_analysis.R data sets
## Original data codebook: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Columns
1. Participant code (an integer from 1 to 30)
2. Activity (one of Standing, Sitting, Laying, Walking, Walking_Downstairs, or 
   Walking_Upstairs)
3. Measurement Name (a total of 66)
4. Average (the mean of all observations across both the test and train datasets)

## Description
The assignment allows for either a narrow or wide output being tidy.  While many
will prefer more columns and only 180 rows (6 x 30), leaving the measurements as columns;
my SQL background compels me to the narrower form with 11880 rows (180 x 66).  I feel the 
narrower form provides more flexibility for additional analysis should it be required.

Details about the various measurements can be found in the original codebook at the URL
listed above.

The participant code is an anonymous number.  The original dataset did not provide any
kind of cross-reference or demographic data associated with the code, so the final dataset 
will also lack any additional information related to the code.

All units are wave magnitudes, normalized to fall within -1.0 to +1.0.  Depending on the
specific measurement, the magnitude may refer to velocity, magnetic field strength, or
other units as explained in the source file features_info.txt.
