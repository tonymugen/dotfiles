local ls = require"luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

ls.add_snippets("cpp", {
	s({
		-- for with size_t
		trig = "fors",
		name = "for loop",
		dscr = "Single for loop with size_t"
	},
	{
		t("for (size_t "),
		i(1, "variable"),
		t(" = "),
		i(2, "start_value"),
		t("; "),
		f(function(args, snip, user_arg_1) 
			return args[1][1] end,
			{1},
			{ user_args = {}}),
		t(" < "),
		i(3, "count"),
		t("; ++"),
		f(function(args, snip, user_arg_1) 
			return args[1][1] end,
			{1},
			{ user_args = {}}),
		t({") {", "\t"}),
		i(4),
		t({";", "}"})
	}),
	s({
		-- foreach loop
		trig = "fore",
		name = "foreach loop",
		dscr = "Loop over a container"
	},
	{
		t("for (auto "),
		i(1, "variable"),
		t(" : "),
		i(2, "container_name"),
		t({") {", "\t"}),
		i(3),
		t({";", "}"})
	}),
	s({
		-- foreach loop with const
		trig = "forec",
		name = "const foreach loop",
		dscr = "Loop over a container with a const parameter"
	},
	{
		t("for (const auto "),
		i(1, "variable"),
		t(" : "),
		i(2, "container_name"),
		t({") {", "\t"}),
		i(3),
		t({";", "}"})
	}),
	s({
		-- for with iterator
		trig = "fori",
		name = "iterator for loop",
		dscr = "For loop with an iterator"
	},
	{
		t("for (auto "),
		i(1, "iterator_name"),
		t(" = "),
		i(2, "container_name"),
		t(".begin(); "),
		f(function(args, snip, user_arg_1) 
			return args[1][1] end,
			{1},
			{ user_args = {}}),
		t(" != "),
		f(function(args, snip, user_arg_1) 
			return args[1][1] end,
			{2},
			{ user_args = {}}),
		t(".end(); ++"),
		f(function(args, snip, user_arg_1) 
			return args[1][1] end,
			{1},
			{ user_args = {}}),
		t({") {", "\t"}),
		i(3),
		t({";", "}"})
	}),
	s({
		-- fstream
		trig = "fstream",
		name = "file stream",
		dscr = "I/O file stream"
	},
	{
		t("std::fstream "),
		i(1, "stream_name"),
		t("("),
		i(2, "file_name"),
		t(", std::ios::"),
		i(3, "in/out"),
		t({");", ""}),
		i(4),
		t({";", ""}),
		f(function(args, snip, user_arg_1) 
			return args[1][1] end,
			{1},
			{ user_args = {}}),
		t({".close();", ""}),
	}),
	s({
		-- class definition
		trig = "class",
		name = "Class definition",
		dscr = "Define a class"
	},
	{
		t("/** \\brief "),
		i(1, "brief_description"),
		t({"", " *", " *", " */", "class "}),
		i(2, "class_name"),
		t({" {", "public:", "\t/** \\brief Default constructor */", "\t"}),
		f(function(args, snip, user_arg_1) 
			return args[1][1] end,
			{2},
			{ user_args = {}}),
		t({"() = default;", "\t"}),
		i(4),
		t({";", "\t/** \\brief Copy constructor","\t *", "\t * \\param[in] toCopy object to copy", "\t */", "\t"}),
		f(function(args, snip, user_arg_1) 
			return args[1][1] end,
			{2},
			{ user_args = {}}),
		t({"(const "}),
		f(function(args, snip, user_arg_1) 
			return args[1][1] end,
			{2},
			{ user_args = {}}),
		t({" &toCopy) = default;", "\t/** \\brief Copy assignment operator","\t *", "\t * \\param[in] toCopy object to copy", "\t * \\return `"}),
		f(function(args, snip, user_arg_1) 
			return args[1][1] end,
			{2},
			{ user_args = {}}),
		t({"` object", "\t */", "\t"}),
		f(function(args, snip, user_arg_1) 
			return args[1][1] end,
			{2},
			{ user_args = {}}),
		t({"& operator=(const "}),
		f(function(args, snip, user_arg_1) 
			return args[1][1] end,
			{2},
			{ user_args = {}}),
		t({" &toCopy) = default;", "\t/** \\brief Move constructor","\t *", "\t * \\param[in] toMove object to move", "\t */", "\t"}),
		f(function(args, snip, user_arg_1) 
			return args[1][1] end,
			{2},
			{ user_args = {}}),
		t({"( "}),
		f(function(args, snip, user_arg_1) 
			return args[1][1] end,
			{2},
			{ user_args = {}}),
		t({" &&toMove) noexcept = default;", "\t/** \\brief Move assignment operator","\t *", "\t * \\param[in] toMove object to move", "\t * \\return `"}),
		f(function(args, snip, user_arg_1) 
			return args[1][1] end,
			{2},
			{ user_args = {}}),
		t({"` object", "\t */", "\t"}),
		f(function(args, snip, user_arg_1) 
			return args[1][1] end,
			{2},
			{ user_args = {}}),
		t({"& operator=( "}),
		f(function(args, snip, user_arg_1) 
			return args[1][1] end,
			{2},
			{ user_args = {}}),
		t({" &&toMove) noexcept = default;", "\t/** \\brief Destructor */", "\t~"}),
		f(function(args, snip, user_arg_1) 
			return args[1][1] end,
			{2},
			{ user_args = {}}),
		t({"() = default;", "private:", "\t"}),
		i(3),
		t({";", "};"}),
	}),
	s({
		-- class definition with inheritance
		trig = "iclass",
		name = "Class definition with inheritance",
		dscr = "Define a class with inheritance"
	},
	{
		t("/** \\brief "),
		i(1, "brief_description"),
		t({"", " *", " *", " */", "class "}),
		i(2, "class_name"),
		t(" : public "),
		i(3, "inheriting_from"),
		t({" {", "public:", "\t"}),
		f(function(args, snip, user_arg_1) 
			return args[1][1] end,
			{2},
			{ user_args = {}}),
		t({"();", "\t"}),
		i(5),
		t({";", "protected:", "\t"}),
		i(4),
		t({";", "};"}),
	}),
	s({
		-- if statement
		trig = "if",
		name = "LuaSnip if",
		dscr = "My version of the if snippet"
	},
	{
		t("if ("),
		i(1, "condition"),
		t({") {", "\t"}),
		i(2),
		t({";", "}"})
	}),
	s({
		-- while loop
		trig = "while",
		name = "LuaSnip while loop",
		dscr = "My version of the while snippet"
	},
	{
		t("while ("),
		i(1, "condition"),
		t({") {", "\t"}),
		i(2),
		t({";", "}"})
	}),
	s({
		-- try/catch
		trig = "try",
		name = "Try/catch",
		dscr = "Try/catch block"
	},
	{
		t({"try {", "\t"}),
		i(3),
		t({";", "} catch("}),
		i(1, "problem"),
		t({") {", "\t"}),
		i(2),
		t({";", "}"})
	}),
	s({
		-- vector definition
		trig = "vector",
		name = "std::vector definition",
		dscr = "Simple vector definition"
	},
	{
		t("vector<"),
		i(1, "type"),
		t("> "),
		i(2, "name"),
		t("{"),
		i(3, "initial_value"),
		t("};")
	}),
	s({
		-- static_cast definition
		trig = "static_cast",
		name = "static_cast definition",
		dscr = "Typical static_cast<>() definition"
	},
	{
		t("static_cast<"),
		i(1, "to_type"),
		t(">("),
		i(2, "variable_name"),
		t(");")
	}),
	s({
		-- Doxygen file comment
		trig = "file",
		name = "Doxygen file preamble",
		dscr = "Fill in a Doxygen file preamble"
	},
	{
		t("/// "),
		i(1, "brief_description"),
		t({"", "/** \\file", " * \\author Anthony J. Greenberg", " * \\copyright Copyright (c) "}),
		i(2, "year"),
		t({"", " * \\version "}),
		i(3, "version"),
		t({"", " *", " * "}),
		i(4, "longer description"),
		t({"", " *", " */"})
	}),
})
