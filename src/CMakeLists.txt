add_executable(SympolisGraphConstruction GraphConstruction.cpp)
target_link_libraries(SympolisGraphConstruction PRIVATE Fishnet::Fishnet Fishnet::Workflow::Settlement CLI11::CLI11 magic_enum::magic_enum spdlog::spdlog)
install(TARGETS SympolisGraphConstruction RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)

add_executable(SympolisGraphComponents GraphComponents.cpp)
target_link_libraries(SympolisGraphComponents PRIVATE Fishnet::Fishnet Fishnet::Workflow CLI11::CLI11 spdlog::spdlog)
install(TARGETS SympolisGraphComponents RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)

add_executable(SympolisSpatialClustering SpatialClustering.cpp)
target_link_libraries(SympolisSpatialClustering PRIVATE Fishnet::Fishnet Fishnet::Workflow::Settlement CLI11::CLI11 magic_enum::magic_enum spdlog::spdlog)
install(TARGETS SympolisSpatialClustering RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)

add_executable(SympolisPolygonOutline PolygonOutline.cpp)
target_link_libraries(SympolisPolygonOutline PRIVATE Fishnet::Fishnet Fishnet::Workflow CLI11::CLI11)
install(TARGETS SympolisPolygonOutline RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)

add_executable(SympolisEdgeVisualization EdgeVisualization.cpp)
target_link_libraries(SympolisEdgeVisualization PRIVATE Fishnet::Fishnet Fishnet::Workflow CLI11::CLI11)
install(TARGETS SympolisEdgeVisualization RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)

add_executable(SympolisMSTVisualization MSTVisualization.cpp)
target_link_libraries(SympolisMSTVisualization PRIVATE Fishnet::Fishnet Fishnet::Workflow CLI11::CLI11)
install(TARGETS SympolisMSTVisualization RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)