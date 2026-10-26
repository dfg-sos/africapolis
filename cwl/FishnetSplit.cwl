cwlVersion: v1.2
class: CommandLineTool
$namespaces:
  eo: "https://dfg-sos.github.io/ontologies/eo-formats#"
  sos: "https://dfg-sos.github.io/ontologies/cwl#"
$schemas:
  - https://dfg-sos.github.io/ontologies/releases/eo-formats/1.0.0/eo-formats.owl
baseCommand: [FishnetVectorFileSplitter]

hints:
  DockerRequirement:
    dockerPull: ghcr.io/descartesresearch/fishnet-apps:2.0.1

requirements:
  InlineJavascriptRequirement: {}
  ResourceRequirement:
    coresMin: 1
    ramMin: 8192

# The tiles are always written as GeoPackages, whatever the format of the input.
arguments:
  - prefix: -f
    valueFrom: GEOPACKAGE

inputs:
  shapefile:
    type: File?
    format: eo:Shapefile
    sos:expectedGeometryType: "Polygon"
    secondaryFiles:
      - "^.shx"
      - "^.dbf"
      - "^.prj"
      - "^.cpg?"
      - "^.qpj?"
    inputBinding:
      prefix: --input
    doc: "Input shapefile with required secondary files (.shx, .dbf, .prj)"

  vectorFile:
    type: File?
    format: eo:GeoPackage
    sos:expectedGeometryType: "Polygon"
    inputBinding:
      prefix: --input
    doc: "Input GeoPackage file (no secondary files required)"

  depth:
    type: int
    inputBinding:
      prefix: --depth

outputs:
  split_files:
    type: File[]
    format: eo:GeoPackage
    sos:expectedGeometryType: "Polygon"
    outputBinding:
      glob: "$((inputs.shapefile|| inputs.vectorFile).nameroot)*.gpkg"
    doc: "Split output GeoPackage files"