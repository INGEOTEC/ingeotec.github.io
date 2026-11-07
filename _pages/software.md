---
title: Software
layout: default
permalink: /software/
published: true
---

{% for category in site.software_category %}
{% assign items = site.software | where: "category", category[0] %}
<div class="section-title" id="{{ category[0] }}">
  <span class="section-tag">Research line</span>
  <h2>{{ category[1].title }}</h2>
</div>
<p class="section-desc">{{ category[1].description }}</p>

{% include card-grid.html items=items %}
{% endfor %}

{% assign others = site.software | where_exp: "item", "item.category == nil" %}
{% if others.size > 0 %}
<div class="section-title" id="other">
  <span class="section-tag">Open source</span>
  <h2>Other</h2>
</div>

{% include card-grid.html items=others %}
{% endif %}
