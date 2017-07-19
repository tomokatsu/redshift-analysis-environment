require 'aws-sdk'
require 'dotenv'
require 'pp'

def create_snapshot
  begin
    resp = $redshift.create_cluster_snapshot({
      snapshot_identifier: ENV["CLUSTEER_NAME"] + "-#{Time.now.strftime("%Y-%m-%d-%H-%M-%S-%Z")}",
      cluster_identifier: ENV["CLUSTEER_NAME"]
    })
    pp resp

  rescue => e
    pp e
  end
end

def restore_cluster
  begin
    resp = $redshift.describe_cluster_snapshots({
      cluster_identifier: ENV["CLUSTEER_NAME"],
      start_time: Time.now.strftime("%Y-%m-%d")
    })

    if resp.snapshots.empty?
      raise "Can't get snapshots."
    end

    snapshots = resp.snapshots.select{|e| !e.snapshot_identifier.start_with?("rs:")}
    snapshots.sort_by{ |x| x.snapshot_create_time }.reverse!

    resp = $redshift.restore_from_cluster_snapshot({
      cluster_identifier: ENV["ANALYSIS_CLUSTER_NAME"],
      snapshot_cluster_identifier: ENV["CLUSTEER_NAME"],
      snapshot_identifier: snapshots[0].snapshot_identifier
    })

    pp resp

  rescue => e
    pp e
  end
end

def delete_cluster
  begin
    resp = $redshift.delete_cluster({
      cluster_identifier: ENV["ANALYSIS_CLUSTER_NAME"],
      skip_final_cluster_snapshot: true
    })
    pp resp

  rescue => e
    pp e
  end
end

# Main
begin
  Dotenv.load

  # Credentials
  $redshift = Aws::Redshift::Client.new(
    region: ENV["AWS_REGION"],
    access_key_id: ENV["AWS_ACCESS_KEY_ID"],
    secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
  )

  if ARGV[0] == "create_snapshot" then
    create_snapshot
  elsif ARGV[0] == "restore_cluster" then
    restore_cluster
  elsif ARGV[0] == "delete_cluster" then
    delete_cluster
  else
    raise "Illegal argument."
  end
rescue => e
  pp e
end
