#!/bin/sh

PROJECT=/src
TARGET=/target/taxonomy/doc

mkdir -p $TARGET

for id in $(cat $PROJECT/structure/espd/codelist/CriteriaTaxonomy-1.2.xml | grep "<Criterion id=" | cut -d '"' -f 2); do
  # echo "Crit: $id"
  echo "
.Expected \`Criterion\` element with id '$id'
[source, xml, indent=0]
----
include::target/taxonomy/CriteriaTaxonomy-snippet.xml[tags=criterion-$id]
----
" > $TARGET/criterion-$id.adoc
done

for id in $(cat $PROJECT/structure/espd/codelist/CriteriaTaxonomy-1.2.xml | grep "<RequirementGroup id=" | cut -d '"' -f 2); do
  # echo "ReqGr: $id"
  echo "
.Expected \`RequirementGroup\` element with id '$id'
[source, xml, indent=0]
----
include::target/taxonomy/CriteriaTaxonomy-snippet.xml[tags=requirement-group-$id]
----
" > $TARGET/requirement-group-$id.adoc
done

for id in $(cat $PROJECT/structure/espd/codelist/CriteriaTaxonomy-1.2.xml | grep "<Requirement id=" | cut -d '"' -f 2); do
  # echo "Req: $id"
  echo "
.Expected \`Requirement\` element with id '$id'
[source, xml, indent=0]
----
include::target/taxonomy/CriteriaTaxonomy-snippet.xml[tags=requirement-$id]
----
" > $TARGET/requirement-$id.adoc
done
