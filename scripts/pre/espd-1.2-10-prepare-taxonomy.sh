#!/bin/sh

mkdir -p /target/taxonomy

# xslt -s:/src/rules/espd-1.1/example/espd-request.xml -xsl:/src/tools/xslt/CriteriaTaxonomy-generate.xslt -o:/target/generated/CriteriaTaxonomy-clean.xml

xslt \
  -s:/src/structure/espd/codelist/CriteriaTaxonomy-1.2.xml \
  -xsl:/src/tools/xslt/espd-1.2/CriteriaTaxonomy-schematron-taxonomy.xslt \
  -o:/target/taxonomy/CriteriaTaxonomy-taxonomy-1.2.sch \
  pattern_only=true

xslt \
  -s:/src/structure/espd/codelist/CriteriaTaxonomy-1.2.xml \
  -xsl:/src/tools/xslt/espd-1.2/CriteriaTaxonomy-schematron-response.xslt \
  -o:/target/taxonomy/CriteriaTaxonomy-response-1.2.sch \
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
  -s:/target/taxonomy/CriteriaTaxonomy-taxonomy-1.2.sch \
  -xsl:/src/tools/xslt/espd-1.2/CriteriaTaxonomy-structure.xslt \
  -o:/target/taxonomy/CriteriaTaxonomy.xml
