module Admin::BaseHelper
  def icon_product
    fa_icon "user", class: "fa-icon-table color-user"
  end

  def icon_show
    fa_icon "list", class: "fa-icon-table color-show"
  end

  def icon_edit
    fa_icon "pencil-square-o", class: "fa-icon-table color-edit"
  end

  def icon_delete
    fa_icon "trash", class: "fa-icon-table color-delete"
  end

  def button_add
    content_tag(
      :div,
      fa_icon(
        "plus",
        text: t("admin.add"),
        class: "fa-1x"
      ),
      class: "button-add"
    )
  end

  def button_remove
    content_tag(
      :div,
      fa_icon(
        "trash",
        text: t("admin.products.form.remove"),
        class: "fa-1x"
      ),
      class: "button-remove"
    )
  end
end
