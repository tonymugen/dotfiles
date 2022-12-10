local ls = require"luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

ls.add_snippets("cmake", {
	s({
		-- minimum required function
		trig = "cmake_min",
		name = "minimum_required",
		dscr = "CMake minimum required version definition"
	},
	{
		t("cmake_minimum_required(VERSION "),
		i(1, "version_number"),
		t(")")
	}),
	s({
		-- project definition
		trig = "proj",
		name = "project",
		dscr = "Project definition"
	},
	{
		t("project("),
		i(1, "name"),
		t(" VERSION "),
		i(2, "version"),
		t(" LANGUAGES "),
		i(3, "languages"),
		t(")")
	})
})
