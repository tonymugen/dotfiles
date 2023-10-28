local ls = require"luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

ls.add_snippets("quarto", {
	s({
		trig = "pdffront",
		name = "PDF front matter",
		dscr = "Set up a Quarto PDF file"
	},
	{
		t({'---', 'title: "'}),
		i(1, "doc_title"),
		t({'"',
			'format:',
			' pdf:',
			'  latex-tinytex: false',
			'  highlight-style: a11y',
			'  code-block-bg: "#F1F2F1"',
			'  code-block-border-left: "#F1F2F1"',
			'  include-in-header:',
			'   - text: |',
			'      \\usepackage{fancyhdr}',
			'      \\pagestyle{fancy}',
			'      \\fancyhf{}',
			'      \\rhead{Page \\thepage}',
			'      \\lhead{'
		}),
		i(2, "short_title"),
		t({'}',
			'      \\chead{Tony Greenberg}',
			'author:',
			' - name: Tony Greenberg',
			'   affiliation: Bayesic Research',
			'   url: www.bayesicresearch.org',
			'license: "CC BY"',
			'---',
			'```{r}',
			'#| echo: false',
			'library(data.table)',
			'library(ggplot2)',
			'library(showtext)',
			'font_add("myriad", regular = "MYRIADPRO-SEMIBOLD.OTF",',
			'\tbold = "MYRIADPRO-BOLD.OTF", italic = "MYRIADPRO-SEMIBOLDIT.OTF")',
			'sessionInfo()',
			'```'
		})
	}),
	s({
		trig = "ggpdf",
		name = "ggplot2 PDF",
		dscr = "Make a ggplot2 plot and save to a PDF file"
	},
	{
		t({'```{r}', '#| fig-cap: "'}),
		i(1, "figure_title"),
		t({'"', '#| fig-width: '}),
		i(2, "fig_width"),
		t({'', '#| fig-height: '}),
		i(3, "fig_height"),
		t({'', 'showtext_auto()', 'ggplot(data = '}),
		i(4, "data_source"),
		t(', aes('),
		i(5, "variables"),
		t({')) +', '\t'}),
		i(7),
		t({'', '\ttheme_classic(base_size = 18, base_family = "myriad") +',
			'\ttheme(strip.background = element_rect(fill = "grey95", linetype = "blank"))',
			'ggsave("'
		}),
		i(6, "pdf_file_name"),
		t('.pdf", width = '),
		f(function(args, snip, user_arg_1) 
			return args[1][1] end,
			{2},
			{ user_args = {}}),
		t(', height = '),
		f(function(args, snip, user_arg_1) 
			return args[1][1] end,
			{3},
			{ user_args = {}}),
		t({', units = "in",', '\t\tdevice = "pdf", useDingbats = FALSE)', '```'})
	})
})
