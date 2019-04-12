#!/bin/sh

mkdir -p /target/taxonomy

# xslt -s:/src/rules/espd-1.1/example/espd-request.xml -xsl:/src/tools/xslt/CriteriaTaxonomy-generate.xslt -o:/target/generated/CriteriaTaxonomy-clean.xml

xslt \
  -s:/src/structure/espd/codelist/CriteriaTaxonomy-1.2.xml \
  -xsl:/src/tools/xslt/espd-1.2/CriteriaTaxonomy-schematron.xslt \
  -o:/target/taxonomy/CriteriaTaxonomy.sch \
  pattern_only=true

xslt \
  -s:/src/structure/espd/codelist/CriteriaTaxonomy-1.2.xml \
  -xsl:/src/tools/xslt/espd-1.2/CriteriaTaxonomy-schematron-response.xslt \
  -o:/target/taxonomy/CriteriaTaxonomy-response.sch \
  pattern_only=true

xslt \
  -s:/src/structure/espd/codelist/CriteriaTaxonomy-1.2.xml \
  -xsl:/src/tools/xslt/espd-1.2/CriteriaTaxonomy-codelist-optional.xslt \
  -o:/target/taxonomy/CriteriaTaxonomy-Optional.xml

xslt \
  -s:/src/structure/espd/codelist/CriteriaTaxonomy-1.2.xml \
  -xsl:/src/tools/xslt/espd-1.2/CriteriaTaxonomy-table.xslt \
  -o:/target/taxonomy/CriteriaTaxonomy.html \
  pattern_only=true

xslt \
  -s:/src/structure/espd/codelist/CriteriaTaxonomy-1.2.xml \
  -xsl:/src/tools/xslt/espd-1.2/CriteriaTaxonomy-snippet.xslt \
  -o:/target/taxonomy/CriteriaTaxonomy-snippet.xml

xslt \
  -s:/target/taxonomy/CriteriaTaxonomy.sch \
  -xsl:/src/tools/xslt/espd-1.2/CriteriaTaxonomy-structure.xslt \
  -o:/target/taxonomy/CriteriaTaxonomy.xml
