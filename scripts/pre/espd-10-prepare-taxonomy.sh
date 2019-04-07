#!/bin/sh

mkdir -p /target/taxonomy

# xslt -s:/src/rules/espd-1.1/example/espd-request.xml -xsl:/src/tools/xslt/CriteriaTaxonomy-generate.xslt -o:/target/generated/CriteriaTaxonomy-clean.xml

xslt \
  -s:/src/structure/espd/codelist/CriteriaTaxonomy.xml \
  -xsl:/src/tools/xslt/CriteriaTaxonomy-schematron.xslt \
  -o:/target/taxonomy/CriteriaTaxonomy.sch \
  pattern_only=true

xslt \
  -s:/src/structure/espd/codelist/CriteriaTaxonomy.xml \
  -xsl:/src/tools/xslt/CriteriaTaxonomy-schematron-response.xslt \
  -o:/target/taxonomy/CriteriaTaxonomy-response.sch \
  pattern_only=true

xslt \
  -s:/src/structure/espd/codelist/CriteriaTaxonomy.xml \
  -xsl:/src/tools/xslt/CriteriaTaxonomy-codelist-optional.xslt \
  -o:/target/taxonomy/CriteriaTaxonomy-Optional.xml

xslt \
  -s:/src/structure/espd/codelist/CriteriaTaxonomy.xml \
  -xsl:/src/tools/xslt/CriteriaTaxonomy-table.xslt \
  -o:/target/taxonomy/CriteriaTaxonomy.html \
  pattern_only=true

xslt \
  -s:/src/structure/espd/codelist/CriteriaTaxonomy.xml \
  -xsl:/src/tools/xslt/CriteriaTaxonomy-snippet.xslt \
  -o:/target/taxonomy/CriteriaTaxonomy-snippet.xml

xslt \
  -s:/target/taxonomy/CriteriaTaxonomy.sch \
  -xsl:/src/tools/xslt/CriteriaTaxonomy-structure.xslt \
  -o:/target/taxonomy/CriteriaTaxonomy.xml
