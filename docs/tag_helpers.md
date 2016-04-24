# Tag Helpers

## Email Wrapper

Main centered container

## Helper

```ruby
def email_wrapper options = {}, &block
  default_options = {
    width: 660,
    inner_bg: '#FFF',
    outer_bg: '#F1F1F1'
  }
  content_tag :table, id: 'email-wrapper', width: '100%', border: 0, cellpadding: 0, cellspacing: 0, bgcolor: outer_bg, styles: "background: #{outer_bg};" do
    content_tag :tr do
      content_tag :td, '&nbsp;', class: 'hide-on-mobile'
      content_tag :td, class: options[:class], width: options.width, bgcolor: inner_bg, styles: "background: #{inner_bg}; #{styles}" do
        block
      end
      content_tag :td, '&nbsp;', class: 'hide-on-mobile'
    end
  end
end
```

## Usage

```ruby
<%= email_wrapper styles: 'font-family:Helvetica,Arial,sans-serif;' do %>
  content
<% end %>
```

## Output

```html
<table id="email-wrapper" width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#F1F1F1", styles="background:#F1F1F1;">
  <tr>
    <td class="hide-on-mobile">&nbsp;</td>
    <td width="660" bgcolor="#FFF" style="background: #FFF;">
      content
    </td>
    <td class="hide-on-mobile">&nbsp;</td>
  </tr>
</table>
```
