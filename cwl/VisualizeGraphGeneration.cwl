cwlVersion: v1.2
class: Workflow
$namespaces:
  eo: "https://dfg-sos.github.io/ontologies/eo-formats#"
  sos: "https://dfg-sos.github.io/ontologies/cwl#"
$schemas:
  - https://dfg-sos.github.io/ontologies/releases/eo-formats/1.0.0/eo-formats.owl
requirements:
- class: InlineJavascriptRequirement
- class: StepInputExpressionRequirement
- class: SubworkflowFeatureRequirement

inputs:
    vectorFile:
        type: File
        format: eo:GeoPackage
        sos:expectedGeometryType: "Polygon"
        doc: "Input GeoPackage, whose settlements carry a FISHNET ID, to visualize the edges of the graph"
    graphConstructionMode:
        type:
          type: enum
          symbols: [BUFFER_SWEEP, DELAUNAY]
        default: DELAUNAY
        doc: "Method used to connect neighbouring settlements"
    graphDistanceThreshold:
        type: float
        default: 200.0
        doc: "Maximum distance in meters between two settlements sharing an edge"
    maxNeighborsPerNode:
        type: int?
        doc: "Maximum number of edges per settlement. Required by the BUFFER_SWEEP mode"
    debug:
        type: boolean
        default: false
        doc: "Enable debug logging"
outputs:
    edges:
        type: File
        outputSource: edge_visualization/edgeVectorFile
steps:
    graph_generation:
        run: GraphConstructionTool.cwl
        in: 
            primaryInput: vectorFile
            mode: graphConstructionMode
            distanceThreshold: graphDistanceThreshold
            maxNeighborsPerNode: maxNeighborsPerNode
            debug: debug
        out: [graphBinary]
    edge_visualization:
        run: EdgeVisualization.cwl
        in:
            geometryFiles:
                source: vectorFile
                valueFrom: $([self])
            graphFile: graph_generation/graphBinary
            outputStem:
                source: vectorFile
                valueFrom: $(self.nameroot)
        out: [edgeVectorFile]
