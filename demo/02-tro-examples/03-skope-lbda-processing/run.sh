#!/usr/bin/env bash

source ../common/query-tro.sh

# ------------------------------------------------------------------------------

bash_cell tro_report << END_CELL

geist report --outputroot products << END_TEMPLATE

{%- use "templates.geist" %}
{%- create datastore="rdflib" %} tro/tro.jsonld {% endcreate %}

{%- html "report.html" %}
{%- head "TRO Report" %}

    <body>
        <h1><img src="https://transparency-certified.github.io/trace-specification/_static/logo.png" alt="Logo" class="logo">  TRO Report</h1>
        <button id="ID_Button">Show/Hide IDs</button>
        <h3>This Transparent Research Object (TRO):</h3>
        {%- map isfilepath=False, mappings="mappings.json" as query_tro %} {% query_tro_str %} {% endmap %}
        {% for _, row in query_tro.iterrows() %}
        <u>{{ row["tro_name"] }}</u>
        <br><br><i class="id_col">TRO ID: {{ row["tro_id"] }}</i>
        <ul>
            <li>Created by: {{ row["tro_creator"] }}</li>
            <li>Created datetime: {{ row["tro_date"] }}</li>
            <li>TRO Description: {{ row["tro_descr"] }}</li>
            <li>Digital artifacts: {{ row["num_of_artifacts"] }}</li>
            <li>Artifact artifact arrangements: {{ row["num_of_arrs"] }}</li>
            <li>Transparent Research Performances (TRPs): {{ row["num_of_trps"] }}</li>
        </ul>
        {% endfor %}

        <button id="TRS-Button" class="button" data-target="TRS-Content">Transparent Research System (TRS)</button>
        <div id="TRS-Content" class="content">
            {%- map isfilepath=False, mappings="mappings.json" as query_trs %} {% query_trs_str %} {% endmap %}
            {% for _, row in query_trs.iterrows() %}
            <u>{{ row["trs_name"] }}</u>
            <br><br><i class="id_col">TRS ID: {{ row["trs_id"] }}</i>
            <ul>
                <li>Publisher: {{ row["trs_publisher"] }}</li>
                <li>TRS Description: {{ row["trs_descr"] }}</li>
                <li>Capabilities: {{ row["num_of_capabilities"] }} (see below)</li>
            </ul>
            {% endfor %}
            {%- table mappings="mappings.json" %}{% query_trs_capability_str %}{% endtable %}
        </div>

        <button id="TRP-Button" class="button" data-target="TRP-Content">Transparent Research Performances (TRPs) and Arrangements</button>
        <div id="TRP-Content" class="content">
            {% img src="trp.svg" %}
                {%- gv_graph "trp", "LR" %}
                nodesep=0.6
                node[shape=box style="filled, rounded" fillcolor="#b3e2cd" peripheries=1 fontname=Courier]
                {%- map isfilepath=False, mappings="mappings.json" as query_trp %} {% query_trp_str %} {% endmap %}
                {% for _, row in query_trp.iterrows() %}
                    {% gv_labeled_edge row["in"], row["out"], row["trp"] %}
                {% endfor %}
                {% gv_end %}
            {% endimg %}
            <u><br><br>Descriptions of these TRPs:</u><br><br>
            {%- table mappings="mappings.json" %}{% query_trp_details_str %}{% endtable %}
        </div>

        <button id="Artifacts-Button" class="button" data-target="Artifacts-Content">Artifacts</button>
        <div id="Artifacts-Content" class="content">
            {%- table mappings="mappings.json" %}{% query_artifact_str %}{% endtable %}
        </div>

        <button id="ArtbyArr-Button" class="button" data-target="ArtbyArr-Content">Artifacts by Arrangement</button>
        <div id="ArtbyArr-Content" class="content">

        {%- query datastore="rdflib", isfilepath=False as _query_arrangement %}
            SELECT DISTINCT ?arrangement (STR(?arrangement) AS ?id) ?name ?descr
            WHERE {
                ?tro          rdf:type    trov:TransparentResearchObject .
                ?tro          trov:hasArrangement ?arrangement .
                ?arrangement  rdfs:label    ?name .
                ?arrangement  rdfs:comment  ?descr .
            }
            ORDER BY ?arrangement
        {% endquery %}

        {%- map isfilepath=False, mappings="mappings.json", on="id" as query_arrangement %} {{ _query_arrangement | df2json }} {% endmap %}
        {% for idx, row in query_arrangement.iterrows() %}
        <u>{{ row["name"] }}</u>
        <br><br><i class="id_col">Arrangement ID: {{ row["id"] }}</i>
        <ul>
            <li>Arrangement Description: {{ row["descr"] }}</li>
            <li>Digital artifacts: {%- table mappings="mappings.json" %}{% query_artifacts_by_arrangement_str row["arrangement"] %}{% endtable %}</li>
        </ul>
        {% endfor %}

</body>
{% style %}
{% script %}
{% endhtml %}

{%- destroy %}

END_TEMPLATE

END_CELL

# ------------------------------------------------------------------------------
