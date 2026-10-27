# Projektskizze Geobranch

- Wir möchten für unser Projekt ein Programm schreiben das 3-dimensionale Voxel Landschaften für Hintergrundbilder generiert Als Grundlage für das generieren wollen wir Perlin Noise nutzten. Des weiteren wollen wir das Ganze in der Gameengine Godot umsetzen damit wir uns nicht mit dem Rendering Rumschlagen müssen.
- Wir wollen den Vorgang verfolgen das wir Noisemaps für Feuchtigkeit und andere parameter erstellen und danach basiert auf den werten auswählen was für Biome in welchen Regionen sind und diese dann generieren.

## Mögliche theoretische Quellen 
	- [Procedural Terrain Generation with Perlin Noise](https://www.jdhwilkins.com/mountains-cliffs-and-caves-a-comprehensive-guide-to-using-perlin-noise-for-procedural-generation/ "https://www.jdhwilkins.com/mountains-cliffs-and-caves-a-comprehensive-guide-to-using-perlin-noise-for-procedural-generation/")
	- https://medium.com/@ashleythedev/understanding-procedural-terrain-generation-in-games-07ac63fca626
	- https://www.redblobgames.com/maps/terrain-from-noise/
	- https://docs.godotengine.org/en/stable/

## Tools
    - Godot
    - Git
    - Github --> (https://github.com/rosaWal23/geobranch)
## Bereits existierende Produkte 
    - https://www.redblobgames.com/maps/mapgen4/
    - https://3d-map-generator.com/3d-map-generator-app/terrain_maker_3d/
    - https://www.world-machine.com/
    - https://quadspinner.com/

| Projektplan |                                                                                                        |
| ----------- | ------------------------------------------------------------------------------------------------------- |
| Datum       | Plan                                                                                                    |
| 28.10       | lernen wie man Godot benutzt, sich mit GitHub vertraut machen, Bischen anschauen wie Noise funktioniert |
| 04.11       | Erste Terrain generation implementieren --> Eine Noise Funktion                                         |
| 11.11       | Erstellung komplizierterer Landschaften durch Kombinieren mehrer Oktaven                                |
| 18.11       | Realistischere Landschaften durch nutzung von Biofaktormaps (Feuchtigkeit, Steilheit...)                |
| 25.11       | Hinzufügen von zufällig platzierten Pflanzen.                                                           |
| 02.12       | UI zum konfigurieren und Bilder exportieren erstelle                                                    |
| 09.12       | Finaler Schliff, Build, Präsentation und Dokumentation                                                  |
 
| Individuelle Ziele                                                                         |                                                                                                                                                                                                                                                                                                                                                  |                                                                                                                                                                                                                                                                                                                                                                                                                  |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Axel                                                                                       | Jan                                                                                                                                                                                                                                                                                                                                               | Priyanka                                                                                                                                                                                                                                                                                                                                                                                                          |
| ich möchte lernen wie man eine solche landshaft construiert und was alles dahinter steckt. | Ich möchte lernen wie Landschaften in Computerspielen generiert werden und ein tieferes Verständnis für Noise Funktionen entwickeln. Des weiteren möchte ich Erfahrung in der Nutzung von Godot sammeln. Auch möchte ich meine GIT-Skills festigen. Schlussendlich möchte ich auch eine schönes Ergebnis haben und Spass beim Programmieren haben | Ich möchte verstehen, wie prozedurale Generation funktioniert und wie mathematische Funktionen (Perlin Noise) zur Erzeugung von Landschaften eingesetzt werden. Ich möchte lernen, wie man theoretische Konzepte aus Mathematik in einem praktischen Projekt anwendet und allgemein meine Fähigkeiten in Programmieren verbessern. Ich möchte auch lernen, wie man mit unterschiedlichen Tools, wie Godot umgeht. |
