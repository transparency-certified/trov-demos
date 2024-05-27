

TRACE_VOCAB=$REPRO_MNT/exports/trov.jsonld
TRO_DECLARATION=tro/tro.jsonld
TRS_CERTIFICATE=trs/trs.jsonld

# ------------------------------------------------------------------------------

bash_cell 'import trov vocabulary' << END_CELL

# Destroy the dataset
geist destroy rdflib --dataset kb --quiet

# Import TRACE vocabulary and TRO Manifest and export as N-TRIPLES
geist create rdflib --dataset kb --inputformat json-ld --inputfile ${TRACE_VOCAB} --infer owl

# Import TRO and TRS as JSON-LD and export as N-TRIPLES
geist export rdflib --dataset kb --outputformat nt | sort | grep trov

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'import tro declaration' << END_CELL

# Import TRACE vocabulary and TRO Manifest and export as N-TRIPLES
geist load rdflib --dataset kb --inputformat json-ld --inputfile ${TRO_DECLARATION}

# Import TRO and TRS as JSON-LD and export as N-TRIPLES
geist export rdflib --dataset kb --outputformat nt | sort | grep trov-example

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'query tro attributes' << END_CELL

# What subclasses of TROAttribute have been defined?

geist query rdflib --dataset kb << __END_QUERY__

    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    PREFIX trov: <https://w3id.org/trace/2023/05/trov#>

    SELECT DISTINCT ?attribute ?attributeLabel ?attributeComment
    WHERE {
        ?attribute      rdfs:subClassOf   trov:TROAttribute .
        ?attribute      rdfs:label        ?attributeLabel .
        ?attribute      rdfs:comment      ?attributeComment .
    } ORDER BY ?attribute ?attributeLabel ?attributeComment
    
__END_QUERY__

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'query trs attributes' << END_CELL

# What subclasses of TRSAttribute have been defined?

geist query rdflib --dataset kb << __END_QUERY__

    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    PREFIX trov: <https://w3id.org/trace/2023/05/trov#>

    SELECT DISTINCT ?attribute ?attributeLabel ?attributeComment
    WHERE {
        ?attribute      rdfs:subClassOf   trov:TRSAttribute .
        ?attribute      rdfs:label        ?attributeLabel .
        ?attribute      rdfs:comment      ?attributeComment .
    } ORDER BY ?attribute ?attributeLabel ?attributeComment
    
__END_QUERY__

# Destroy the dataset
geist destroy rdflib --dataset kb

END_CELL

# ------------------------------------------------------------------------------
