const Gtk = imports.gi.Gtk;

let Extension = imports.misc.extensionUtils.getCurrentExtension();
let Convenience = Extension.imports.convenience;

const Gettext = imports.gettext.domain('scroll-workspaces');
const _ = Gettext.gettext;

function init() {
	Convenience.initTranslations("scroll-workspaces");
}

function buildPrefsWidget() {
	let settings = Convenience.getSettings();
	let frame = new Gtk.Box({
		orientation: Gtk.Orientation.VERTICAL,
		margin_top: 30,
		margin_bottom: 30,
		margin_start: 30,
		margin_end: 30,
		spacing: 5
	});

	(function() {
		let hbox = new Gtk.Box({
			orientation: Gtk.Orientation.HORIZONTAL,
			spacing: 50
		});

		let label = new Gtk.Label({
			label: _("Ignore last workspace:"),
			use_markup: false,
			xalign: 0,
			hexpand: true
		});
		let checkbutton = new Gtk.CheckButton();

		hbox.append(label, true, true, 0);
		hbox.append(checkbutton);
		frame.append(hbox);

		checkbutton.set_active(settings.get_boolean('ignore-last-workspace'));
		checkbutton.connect('toggled', function(sw) {
			var newval = sw.get_active();
			if (newval != settings.get_boolean('ignore-last-workspace')) {
				settings.set_boolean('ignore-last-workspace', newval);
			}
		});
	})();

	(function() {
		let hbox = new Gtk.Box({
			orientation: Gtk.Orientation.HORIZONTAL,
			spacing: 50
		});

		let label = new Gtk.Label({
			label: _("Minimum delay between scroll events (ms)")+"\n<small>("+_("prevents accidental double-scrolling")+")</small>",
			use_markup: true,
			xalign: 0,
			hexpand: true
		});
		let adjustment = new Gtk.Adjustment({
			lower: 0,
			upper: 500,
			step_increment: 10
		});
		let scale = new Gtk.Scale({
			orientation: Gtk.Orientation.HORIZONTAL,
			digits:0,
			adjustment: adjustment,
			value_pos: Gtk.PositionType.RIGHT,
			draw_value: true
		});

		hbox.append(label);
		hbox.append(scale, true, true, 0);
		frame.append(hbox);

		scale.set_value(settings.get_int('scroll-delay'));
		scale.set_size_request(200, -1);
		scale.connect('value-changed', function(sw) {
			var newval = sw.get_value();
			if (newval != settings.get_int('scroll-delay')) {
				settings.set_int('scroll-delay', newval);
			}
		});
	})();

	(function() {
		let hbox = new Gtk.Box({
			orientation: Gtk.Orientation.HORIZONTAL,
			spacing: 50
		});

		let label = new Gtk.Label({
			label: _("Wrap around:"),
			use_markup: false,
			xalign: 0,
			hexpand: true
		});
		let checkbutton = new Gtk.CheckButton();

		hbox.append(label, true, true, 0);
		hbox.append(checkbutton);
		frame.append(hbox);

		checkbutton.set_active(settings.get_boolean('wrap'));
		checkbutton.connect('toggled', function(sw) {
			var newval = sw.get_active();
			if (newval != settings.get_boolean('wrap')) {
				settings.set_boolean('wrap', newval);
			}
		});
	})();

	(function() {
		let hbox = new Gtk.Box({
			orientation: Gtk.Orientation.HORIZONTAL,
			spacing: 50
		});

		let label = new Gtk.Label({
			label: _("Show indicator:"),
			use_markup: false,
			xalign: 0,
			hexpand: true
		});
		let checkbutton = new Gtk.CheckButton();

		hbox.append(label, true, true, 0);
		hbox.append(checkbutton);
		frame.append(hbox);

		checkbutton.set_active(settings.get_boolean('indicator'));
		checkbutton.connect('toggled', function(sw) {
			var newval = sw.get_active();
			if (newval != settings.get_boolean('indicator')) {
				settings.set_boolean('indicator', newval);
			}
		});
	})();

	return frame;
}
