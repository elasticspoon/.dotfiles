IRB.conf[:SAVE_HISTORY] = 10_000

def colorize(text, color_code) = "\e[#{color_code}m#{text}\e[0m"
def black(text) = colorize text, 30
def red(text) = colorize text, 31
def green(text) = colorize text, 32
def brown(text) = colorize text, 33
def blue(text) = colorize text, 34
def purple(text) = colorize text, 35
def cyan(text) = colorize text, 36
def gray(text) = colorize text, 37

if defined? Reline::Face
  Reline::Face.config(:completion_dialog) do |conf|
    conf.define(:default, foreground: "#cad3f5", background: "#363a4f")
    conf.define(:enhanced, foreground: "#cad3f5", background: "#5b6078")
    conf.define(:scrollbar, foreground: "#c6a0f6", background: "#181926")
  end
else
  IRB.conf[:USE_AUTOCOMPLETE] = false
end

if defined?(Rails) && defined?(Rails.env)
  prompt = case Rails.env
           when 'development'
             green Rails.env
           when 'production'
             red Rails.env
           else
             blue Rails.env
           end

  IRB.conf[:PROMPT][:RAILS] = {
    PROMPT_I: "#{prompt}:%03n:%i> ",
    PROMPT_N: "#{prompt}:%03n:%i> ",
    PROMPT_S: "#{prompt}:%03n:%i* ",
    PROMPT_C: "#{prompt}:%03n:%i? ",
    RETURN: " => %s\n"
  }

  IRB.conf[:PROMPT_MODE] = :RAILS
end
