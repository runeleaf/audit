require 'active_record'
require 'active_support/concern'
require 'audit/version'
require 'audit/audit_log'
require 'audit/transcribe'
ActiveRecord::Base.send :include, Audit::Transcribe
