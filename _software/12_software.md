---
layout: post
title: EncExp
description: Tools to create and use explainable embeddings
category: textclassification
github: https://github.com/INGEOTEC/EncExp
meta: Python
---

EncExp (Encaje Explicable) is a set of tools for creating and using explainable embeddings. Unlike embeddings estimated with GloVe or Word2Vec, each component of an EncExp vector has a meaning: its value indicates whether the word associated with the component might be present in the sentence. The embedding is estimated by solving binary self-supervised classification problems, where the label is the presence of a particular token, with a linear Support Vector Machine.

Source Code in <a class="social-button github" href="https://github.com/INGEOTEC/EncExp" itemprop="sameAs" target="_blank"> <i class="fab fa-github"></i></a>

The documentation is on [ingeotec.github.io/EncExp](https://ingeotec.github.io/EncExp/).
