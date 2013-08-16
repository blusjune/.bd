#!/usr/bin/env python
# -*- coding: utf-8 *-*
#textmining_s20130814v011_tfidf.py
#_ver="20130816_150745";


'''
The following is a naive, unsupervised text summarizer.
It extracts N of the text's most salient sentences.
Salience is defined as the average of the tf-idf weights of the words in a sentence.
'''
from nltk import sent_tokenize, word_tokenize
from collections import Counter
from math import log10
import os, sys
import fileinput




num_to_extract = 3

text = ""
for _line in fileinput.input():
	text += _line

sentences = sent_tokenize(text)
collections_tokens = word_tokenize(text)
collection_counter = Counter(collections_tokens)
sent_saliences = []
scored_sents = []

for index, sentence in enumerate(sentences):
    sent_salience = 0
    sent_tokens = word_tokenize(sentence)
    sent_counter = Counter(sent_tokens)
    for token in sent_tokens:
        tf = sent_counter[token]
        idf = log10(len(sentences) / sent_counter[token])
        tfidf = tf * idf
        sent_salience += tfidf
    normalized_salience = sent_salience / len(sent_tokens)
    sent_saliences.append(normalized_salience)
    scored_sents.append((normalized_salience, sentence, index))

scored_sents.sort(key=lambda tup: tup[0], reverse=True)
selected_sents = sorted(scored_sents[:num_to_extract], key=lambda tup: tup[2])

''' # Uncomment this block for verbose output
print "-------------------------------"
print 'Original text: (%s sentences)' % (len(sentences))
print "-------------------------------"
print '%s\n' % (text)
print "-------------------------------"
print 'Extracted text: (%s sentences)' % (num_to_extract)
print "-------------------------------"
'''
print '%s' % (' '.join([i[1] for i in selected_sents]))

''' # Uncomment this block for verbose output
print "\n\n"
print "================================================"
print "SUMMARY: Extracting Important Sentences"
print "------------------------------------------------"
print 'Original text  : %s sentences' % (len(sentences))
print 'Extracted text : %s sentences' % (num_to_extract)
print "================================================"
'''

sys.exit(0)
