[% FOR page IN pages %]
# [% page.title %]
[% page.body %]


<p style="margin-top: 30px; font-size: small">
zim://[% page.name %] <br/>
Exported on [% strftime("%Y-%0m-%0d")  %]
</p>
[% END %]
