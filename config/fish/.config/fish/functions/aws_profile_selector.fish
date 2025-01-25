function aws_profile_selector
    # Rustプログラムを実行して環境変数設定スクリプトを生成
    ~/ghq/github.com/krzmknt/awsprofile-switcher/target/release/awsprofile

    # 環境変数を設定するスクリプトをソース
    source /tmp/awsprofile/set_aws_profile.sh

    # 確認のためにAWS_PROFILEを表示
    echo "AWS_PROFILE is set to $AWS_PROFILE"
end
