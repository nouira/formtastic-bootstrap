# encoding: utf-8
require 'spec_helper'

describe 'horizontak' do

  include FormtasticSpecHelper

  before do
    @output_buffer = ''
    mock_everything
    Formtastic::Helpers::FormHelper.builder = FormtasticBootstrap::FormBuilder
  end

  describe "when horizontal option is set" do
    before do
      concat(semantic_form_for(@new_post, :html => { :class => 'form-horizontal' }) do |builder|
        concat(builder.input(:title, :as => :string))
      end)
    end

    it "should have control-group class" do
      output_buffer.should have_tag("form div.control-group")
    end

    it "should have control-label class" do
      output_buffer.should have_tag("form label.control-label")
    end
  end

  describe "when object is provided" do
    before do
      concat(semantic_form_for(@new_post) do |builder|
        concat(builder.input(:title, :as => :string))
      end)
    end

    it "should not have control-group class" do
      output_buffer.should_not have_tag("form div.control-group")
    end

  end

end

