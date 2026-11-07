---
title: Talks
layout: default
permalink: /talk/
published: true
talk_sections:
  - key: outreach
    tag: Outreach
    title: Outreach
    description: Outreach talks on Natural Language Processing, Artificial Intelligence and their applications, aimed at general audiences.
  - key: textclassification
    tag: Course
    title: Text Classification
    description: Technical talks and courses on text classification and opinion mining, aimed at academic audiences.
  - key: metricsearch
    tag: Research line
    title: Metric Search
    description: Search in metric spaces.
  - key: competitions
    tag: Competition
    title: Competitions
    description: "INGEOTEC's participation in international evaluation campaigns of NLP systems: IberLEF 2023 (Jaén, Spain) and MexLEF 2023 (Puebla, Mexico)."
---

<p class="section-desc">Presentations given by the group at conferences, international competitions and outreach events, as listed at <a href="https://ingeotec.github.io/talks/">ingeotec.github.io/talks</a>.</p>

{% for section in page.talk_sections %}
{% assign items = site.talk | where: "section", section.key %}
<div class="section-title" id="{{ section.key }}">
  <span class="section-tag">{{ section.tag }}</span>
  <h2>{{ section.title }}</h2>
</div>
<p class="section-desc">{{ section.description }}</p>

{% include card-grid.html items=items %}
{% endfor %}
