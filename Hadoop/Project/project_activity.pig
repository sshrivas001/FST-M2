-- Load data from HDFS
inputDialogues4 = LOAD 'hdfs:///user/padmini/inputs/episodeIV_dialogues.txt' USING PigStorage('\t') AS (name:chararray, lines:chararray);
inputDialogues5 = LOAD 'hdfs:///user/padmini/inputs/episodeV_dialogues.txt' USING PigStorage('\t') AS (name:chararray, lines:chararray);
inputDialogues6 = LOAD 'hdfs:///user/padmini/inputs/episodeVI_dialogues.txt' USING PigStorage('\t') AS (name:chararray, lines:chararray);

-- Filter out the first 2 lines from each file
ranked4 = RANK inputDialogues4;
OnlyDialogues4 = FILTER ranked4 BY (rank_inputDialogues4 > 2);
ranked5 = RANK inputDialogues5;
OnlyDialogues5 = FILTER ranked5 BY (rank_inputDialogues5 > 2);
ranked6 = RANK inputDialogues6;
OnlyDialogues6 = FILTER ranked6 BY (rank_inputDialogues6 > 2);

-- Merge the three inputs
inputData = UNION OnlyDialogues4, OnlyDialogues5, OnlyDialogues6;

-- Group by name
groupByName = GROUP inputData BY name;

-- Count the number of lines by each character
names = FOREACH groupByName GENERATE $0 as name, COUNT($1) as no_of_lines;
namesOrdered = ORDER names BY no_of_lines DESC;

-- Remove the ouputs folder
rmf hdfs:///user/padmini/outputs;

-- Store result in HDFS
STORE namesOrdered INTO ' hdfs:///user/padmini/outputs' USING PigStorage('\t');
