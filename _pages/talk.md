---
title: Talks
layout: default
permalink: /talk/
published: true
---

<p class="section-desc">Presentations given by the group at conferences, international competitions and outreach events. Each card opens the slides.</p>

{% comment %} The sections and talks live in _data/talks.yml (review fix-2). {% endcomment %}
{% for section in site.data.talks %}
<div class="section-title" id="{{ section.key }}">
  <span class="section-tag">{{ section.tag }}</span>
  <h2>{{ section.title }}</h2>
</div>
<p class="section-desc">{{ section.description }}</p>

{% include card-grid.html items=section.talks %}
{% endfor %}
