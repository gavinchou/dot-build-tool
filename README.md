## graphviz-generated svg highlight plugin

This is a build tool integrated with highlight plugin for building dot files to
svg file. It can generate more interactive svg, by injecting code, especially
for call graphs without any auxiliary external files.

Style 1: highlight with color
Click on the element and call path will be highlighted in blue.

<img src="demo_color.png" width=500/>

Style 2: highlight with opacity
Click on the element and call path will be highlighted, and the other elements
will be faded away.

<img src="demo_fade.png" width=500/>

### prerequisites
0. dot - graphviz version 2.41.20190308.1641 (20190308.1641)
	* new versions should work, if not I will fix it
	* lower versions may work, but not tested yet, I am lazy...
1. GNU sed, if you don't have one, modify the build script to fit the purpose

### usage

```
sh build_call_graph.sh ${src} ${out}
```

where `src` is input .dot file name, and `out` is output .svg file name.
let's say the output is a.svg, when it's done, open a.svg with any browser.

### how it works
1. use graphviz `dot` to generate .svg file from .dot file
	let's say the output is a.svg and input is a.dot
2. replace the last line of a.svg, `</svg>`, with content of
	 `call_graph_highlight_plugin.xml`
3. append `</svg>` to a.svg again

Note that, if you already have a .svg file, you can do step 2 and 3 manually to
embed.

### build you own style

As you can see, the secret is all in `call_graph_highlight_plugin.xml`. To
customize styles or add more features, you need to modify it.

The default style is highlight with color blue, and you can switch to the other
style by modifying `<script>` section of  `call_graph_highlight_plugin.xml`

```
// configure to switch hilight effect
const HILIGHT = 1;
const FADE = 2;
var style = FADE; // change this to FADE
```

If the built-in styles are not what your favor, you can build your own style by
modifying the `<style>` section of the xml file

```
<style>
.node {
  fill: blue;
}
.node:hover {
  fill: lightblue;
}
.fade {
  opacity: 0.2;
}
.fade:hover {
  opacity: 1.0;
}
.arrow-path {
  stroke: blue;
}
.arrow-head-tail {
  fill: blue;
  stroke: blue;
}
</style>
```

Note: for more styles, you need to know something about css and javascript.
