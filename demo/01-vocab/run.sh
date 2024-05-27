#!/usr/bin/env bash

TRACE_VOCAB=$REPRO_MNT/exports/trov.jsonld
GEIST_TEMPLATES=templates.geist

# ------------------------------------------------------------------------------

bash_cell 'load trov vocabulary without inferences' << END_CELL

# Destroy the dataset
geist destroy rdflib --dataset kb --quiet

# Import TRACE vocabulary and export as N-TRIPLES
geist create rdflib --dataset kb --inputformat json-ld --inputfile ${TRACE_VOCAB} --infer none

END_CELL

# ------------------------------------------------------------------------------


bash_cell 'query subclass vocab' << END_CELL

# What (ParentClass, ChildClass) pairs does trov vocabulary have?

geist report --outputroot products << END_TEMPLATE

{%- use "${GEIST_TEMPLATES}" %}
{%- query datastore="rdflib", isfilepath=False as query_subclass_vocab %}
    PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

    SELECT DISTINCT ?ParentLabel ?ChildLabel
    WHERE {
        ?ParentClass    rdf:type        rdfs:Class ;
                        rdfs:label      ?ParentLabel .
        
        ?ChildClass     rdfs:subClassOf ?ParentClass ;
                        rdf:type        rdfs:Class ;
                        rdfs:label      ?ChildLabel .

        FILTER (?ParentLabel != ?ChildLabel)
    }
    ORDER BY ?ParentLabel ?ChildLabel
{% endquery %}

{%- html "report_subclass.html" %}
{%- head "Subclass Report" %}
    <body>
        <h1>Visualize subclass of the vocabularies</h1>
        <h4>1. SVG</h4>
        {% img src="img.svg", width="80%" %}
            {%- gv_graph "subclass_vocab_graph", "LR" %}
            {%- gv_title "Subclass Vocab Graph" %}

            node[shape=box style="filled, rounded" fillcolor="#b3e2cd" peripheries=1 fontname=Courier]
            {% for _, row in query_subclass_vocab.iterrows() %}
                {% gv_edge row["ChildLabel"], row["ParentLabel"] %}
            {% endfor %}

            {% gv_end %}
        {% endimg %}

        <h4>2. GV</h4>
        {% img src="img.gv" %}
            {%- gv_graph "subclass_vocab_graph", "LR" %}
            {%- gv_title "Subclass Vocab Graph" %}

            node[shape=box style="filled, rounded" fillcolor="#b3e2cd" peripheries=1 fontname=Courier]
            {% for _, row in query_subclass_vocab.iterrows() %}
                {% gv_edge row["ChildLabel"], row["ParentLabel"] %}
            {% endfor %}

            {% gv_end %}
        {% endimg %}
        
        <h4>3. Table</h3>
        {%- table %}
            {{ query_subclass_vocab | df2json }}
        {% endtable %}
</body>
{% endhtml %}
{%- destroy %}
    
END_TEMPLATE

END_CELL

# ------------------------------------------------------------------------------

