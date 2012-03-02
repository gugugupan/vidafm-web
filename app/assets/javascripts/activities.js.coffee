# Add mention.
$(".action-mention").live "click", (e)->
	name = $(@).closest(".box-wrapper").find(".author").get(0).innerText
	contentEl = $("#new_comment #content")
	contentEl.val contentEl.val() + "@" + name + " "

	# Focus input field.
	contentEl.focus()