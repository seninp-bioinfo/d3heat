## d3heat - a fixed-height and width heatmap for [EDGE](https://bioedge.lanl.gov/edge_ui/) display.

### 0.0. A clickable screenshot:
![A heatmap example](https://raw.githubusercontent.com/seninp-bioinfo/d3heat/master/site/screen01.png)

### 0.1. The input file format:
Currently the javascript code fetches with d3's `d3.tsv` a three-column TSV file formatted as follows:

    "TAXA"	"PROJECT"	"ABUNDANCE"
    "Acetobacteraceae"	"SRR059928"	0
    "Cellulomonadaceae"	"SRR059928"	0
    "Mycoplasmataceae"	"SRR059928"	0.02
    "Clostridiaceae"	"SRR059928"	0.01
    "Dermacoccaceae"	"SRR059928"	0.02
    "Eubacteriaceae"	"SRR059928"	0

### 0.2. The implementation notes:
The heatmap code is built upon [D3.js](https://d3js.org/), the demo webpage uses [Bootstrap](http://getbootstrap.com/), [jQuery](http://jquery.com/), and [Select2](https://select2.github.io/) plugin for a pretty formatting.

## Made with Aloha!
![Made with Aloha!](https://raw.githubusercontent.com/GrammarViz2/grammarviz2_src/master/src/resources/assets/aloha.jpg)
