package cmd

import (
	"github.com/cosmos/cosmos-sdk/codec"
	cosmostypes "github.com/cosmos/cosmos-sdk/codec/types"
	cross "github.com/datachainlab/cross/x/core"
	"github.com/mitchellh/go-homedir"
	"github.com/pkg/errors"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"

	"github.com/datachainlab/fabric-besu-cross-demo/cmds/erc721/config"
	exttypes "github.com/datachainlab/fabric-besu-cross-demo/contracts/extension/types"
)

var cfgFile string

var rootCmd = &cobra.Command{
	Use:   "erc721cli",
	Short: "Operate erc721 contract",
}

func init() {
	rootCmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file (default is $HOME/.fabric-besu-cross-demo.yaml)")

	interfaceRegistry := cosmostypes.NewInterfaceRegistry()
	cdc := codec.NewProtoCodec(interfaceRegistry)
	cross.AppModuleBasic{}.RegisterInterfaces(interfaceRegistry)
	exttypes.RegisterInterfaces(interfaceRegistry)

	var cmdCfg config.Config
	ctx := &config.Context{Config: &cmdCfg, Codec: cdc}

	rootCmd.AddCommand(
		getCmd(ctx),
		crossCmd(ctx),
		erc721Cmd(ctx),
	)

	rootCmd.PersistentPreRunE = func(cmd *cobra.Command, _ []string) error {
		return initConfig(ctx)
	}
}

func Execute() error {
	return rootCmd.Execute()
}

func initConfig(ctx *config.Context) error {
	if cfgFile != "" {
		viper.SetConfigFile(cfgFile)
	} else {
		home, err := homedir.Dir()
		if err != nil {
			return errors.Wrap(err, "Failed to change dir")
		}

		viper.AddConfigPath(home)
		viper.SetConfigName(".fabric-besu-cross-demo")
	}

	viper.AutomaticEnv() // read in environment variables that match

	if err := viper.ReadInConfig(); err != nil {
		return errors.Wrap(err, "Failed to read config file")
	}

	if err := viper.Unmarshal(ctx.Config); err != nil {
		return errors.Wrap(err, "Failed to unmarshal")
	}
	return nil
}
