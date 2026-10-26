cwlVersion: v1.2
class: CommandLineTool
$namespaces:
  eo: "https://dfg-sos.github.io/ontologies/eo-formats#"
  sos: "https://dfg-sos.github.io/ontologies/cwl#"
$schemas:
  - https://dfg-sos.github.io/ontologies/releases/eo-formats/1.0.0/eo-formats.owl
baseCommand: [FishnetVectorFilePreprocessor]
hints:
  DockerRequirement:
    dockerPull: ghcr.io/descartesresearch/fishnet-apps:2.0.1
requirements:
  InlineJavascriptRequirement: {}
  ResourceRequirement:
    coresMin: 1
    ramMin: 1024
  # The preprocessor reads its filters from a json document. It is generated from the inputs
  # below, so that the filters are configured in CWL like every other parameter of the workflow.
  InitialWorkDirRequirement:
    listing:
      - entryname: filters.json
        entry: |-
          ${
            var filters = [];
            if (inputs.minArea !== null) {
              filters.push({"type": "ApproxAreaFilter", "required-area": inputs.minArea});
            }
            if (inputs.dropContainedPolygons) {
              filters.push({"type": "InsidePolygonFilter"});
            }
            return JSON.stringify({"filters": filters}, null, 2);
          }
arguments:
  - prefix: --config
    valueFrom: filters.json
inputs:
  vectorFile:
    type: File
    format: eo:GeoPackage
    sos:expectedGeometryType: "Polygon"
    inputBinding:
      prefix: --input
  minArea:
    type: float?
    doc: "Drop settlement polygons covering less than this area in square meters. No area filter is applied when omitted"
  dropContainedPolygons:
    type: boolean
    default: false
    doc: "Drop settlement polygons which are fully contained in another settlement polygon"
  skipFilter:
    type: boolean
    default: false
    doc: "Skip the filtering process and return the input vector file with Fishnet IDs as output"
    inputBinding:
      prefix: --no-filter
outputs:
  filteredVectorFile:
    type: File
    format: eo:GeoPackage
    sos:expectedGeometryType: "Polygon"
    outputBinding:
      glob: "*_filtered.gpkg"  # Gather all files associate with the vector file
