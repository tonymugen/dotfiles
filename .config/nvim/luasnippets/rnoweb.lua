local ls = require"luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

ls.add_snippets("rnoweb", {
	s({
		trig = "ggpdf",
		name = "ggplot2 PDF",
		dscr = "Dump a ggplot2 plot to a PDF file"
	},
	{
		t({"\\begin{center}", "<<results=tex>>=", "pdfFlNam <- "}),
		i(1, "file_name"),
		t({".pdf", "showtext_auto()", "ggplt(data = "}),
		i(2, "data.table name"),
		t(", aes("),
		i(3, "plot parameters"),
		t({")) +", "\t"}),
		i(6),
		t({'', '\ttheme_classic(base_size = 18, base_family = "myriad") +',
			'\ttheme(strip.background=element_rect(fill="grey95", linetype="blank")) +',
			'ggsave(pdfFlNam, width = '
		}),
		i(4, "width"),
		t(", height = "),
		i(5, "height"),
		t({', units="in", device="pdf", useDingbats=FALSE)',
			'cat("\\\\includegraphics{", pdfFlNam, "}\\n\\n", sep="")', '@', "\\end{center}"
		})
	})
})
