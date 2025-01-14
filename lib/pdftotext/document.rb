module Pdftotext
  class Document
    attr_reader :path

    def initialize(path)
      @path = File.expand_path(path)
    end

    def text(pat)
      `pdftotext #{path} -layout`
      File.read(path.gsub('.pdf', '.txt'), encoding: 'iso-8859-1')
    end

    def pages(options={})
      pages = text(options).split("\f")
      pages.each_with_index.map { |t,i| Page.new text: t, number: i+1 }
    end
  end
end
