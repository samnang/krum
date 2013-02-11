class GroupDecorator < ApplicationDecorator
  decorates :group

  def logo_link
    h.link_to h.image_tag(group.avatar.url(:thumb), alt: group.name), group.url_1
  end

  def name_link
    h.link_to group.name, group.url_1
  end

  def email_link
    h.mail_to group.email if group.email?
  end

  def url_2_link
    h.link_to group.url_2, group.url_2 if group.url_2?
  end

  def delete_link
    h.link_to "Delete Group", group,
        title: "Delete Group",
        confirm: "Are you sure, you want to delete this group?",
        method: :delete,
        class: 'icon-remove'
  end

  def edit_link
    h.link_to "Edit Group", h.edit_group_path(group),
        title: "Edit Group",
        class: 'icon-edit'
  end
end
