#!/usr/bin/env python
# -*- coding: utf-8 *-*
#textmining_s20130814v010_tfidf.py
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

'''
text = """
Four score and seven years ago our fathers brought forth on this continent,
 a new nation, conceived in Liberty, and dedicated to the proposition that
 all men are created equal.
Now we are engaged in a great civil war, testing whether that nation, or any
nation so conceived and so dedicated, can long endure. We are met on a great
battlefield of that war. We have come to dedicate a portion of that field,
as a final resting place for those who here gave their lives that that nation
might live. It is altogether fitting and proper that we should do this.
But, in a larger sense, we cannot dedicate?we cannot consecrate?we cannot
hallow?this ground. The brave men, living and dead, who struggled here, have
consecrated it, far above our poor power to add or detract. The world will
little note, nor long remember what we say here, but it can never forget what
 they did here. It is for us the living, rather, to be dedicated here to the
 unfinished work which they who fought here have thus far so nobly advanced.
 It is rather for us to be here dedicated to the great task remaining before
 us?that from these honored dead we take increased devotion to that cause for
 which they gave the last full measure of devotion?that we here highly resolve
 that these dead shall not have died in vain?that this nation, under God, shall
  have a new birth of freedom? and that government of the people, by the people
  , for the people, shall not perish from the earth.
"""
'''


text = ""
for _line in fileinput.input():
	text += _line
print "-------------------------------"
print ">>> OK, now start processing..."
print "-------------------------------"

sentences = sent_tokenize(text)
collections_tokens = word_tokenize(text)
collection_counter = Counter(collections_tokens)
sent_saliences = []
scored_sents = []
num_to_extract = 3

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
print "-------------------------------"
print 'Original text:'
print "-------------------------------"
print '%s\n--\nNumber of sentences: %s\n\n' % (
    text, len(sentences))
print "-------------------------------"
print 'Extracted text:'
print "-------------------------------"
print '%s\n--\nNumber of sentences: %s' % (
    ' '.join([i[1] for i in selected_sents]), num_to_extract)


